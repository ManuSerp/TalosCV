#include <boost/filesystem.hpp>
#include <std_srvs/Empty.h>

#include "tiago_controller/joint_controller.hpp"

#include <inria_wbc/utils/trajectory_handler.hpp>

namespace tiago_controller
{

  inline pinocchio::SE3 geometry_to_se3(const geometry_msgs::Pose &pose)
  {
    Eigen::Vector3d translation(pose.position.x, pose.position.y, pose.position.z);
    Eigen::Quaterniond rotation(pose.orientation.w, pose.orientation.x, pose.orientation.y, pose.orientation.z);
    return pinocchio::SE3(rotation, translation);
  }

  inline geometry_msgs::Pose se3_to_geometry(const pinocchio::SE3 &se3)
  {
    geometry_msgs::Pose pose;

    pose.position.x = se3.translation()(0);
    pose.position.y = se3.translation()(1);
    pose.position.z = se3.translation()(2);

    Eigen::Quaterniond q(se3.rotation());
    pose.orientation.x = q.coeffs()(0);
    pose.orientation.y = q.coeffs()(1);
    pose.orientation.z = q.coeffs()(2);
    pose.orientation.w = q.coeffs()(3); // yes, not the same as constructor!

    return pose;
  }

  bool JointController::init(
      hardware_interface::PositionJointInterface *position_iface,
      hardware_interface::VelocityJointInterface *velocity_iface,
      hardware_interface::JointStateInterface *joint_state_iface,
      ros::NodeHandle &root_nh, ros::NodeHandle &control_nh)
  {
    ROS_INFO("LOADING TIAGO JOINT CONTROLLER... (JointController::init)");

    readParametersROS(control_nh); // we need this to get the iwbc.yaml
    initInriaWbc();                // we need to call this first to get the list of joints

    for (auto &jt_name : wbc_joint_names_)
    {
      try
      {
        rc_joints_.push_back(position_iface->getHandle(jt_name));
        rc_joint_states_.push_back(joint_state_iface->getHandle(jt_name));
      }
      catch (...)
      {
        ROS_ERROR_STREAM("Could not find joint handle '" << jt_name << " in initJoints");
        stop_controller_ = false;
        return false;
      }
    }
    ROS_INFO_STREAM("initJoints: done [" << wbc_joint_names_.size() << "  joints]");

    stop_controller_ = false;

    // ROS stuffs: initialize the services and topic
    // services
    service_move_ = control_nh.advertiseService("move", &JointController::move_service_cb, this);
    service_traj_mode_ = control_nh.advertiseService("traj_mode", &JointController::traj_mode_service_cb, this);
    service_tracking_mode_ = control_nh.advertiseService("tracking_mode", &JointController::tracking_mode_service_cb, this);
    // subscribers
    sub_ee_tracking_ = control_nh.subscribe("ee_target", 5, &JointController::tracking_ee_cb, this);
    sub_head_tracking_ = control_nh.subscribe("head_target", 5, &JointController::tracking_head_cb, this);
    // publishers
    pub_ee_ = control_nh.advertise<geometry_msgs::Pose>("ee_pose", 100);
    pub_head_ = control_nh.advertise<geometry_msgs::Pose>("head_pose", 100);


    // TTS client
    tts_client_ = std::make_shared<TextToSpeechClient>("/tts");
    tts_client_->text_to_speech("Code ready.");

    return true;
  }

  void JointController::readParametersROS(ros::NodeHandle &controller_nh)
  {
    {
      std::string name = "/tiago_controller/yaml_inria_wbc";
      if (!getParameter(name, yaml_inria_wbc_, controller_nh))
        ROS_ERROR_STREAM("/talos_controller/yaml_inria_wbc parameter not found, needed for inria_wbc controller parameters");
      ROS_INFO_STREAM("Using yaml:" << yaml_inria_wbc_);
    }
    {
      std::string name = "/tiago_controller/base_directory";
      if (!getParameter(name, base_directory_, controller_nh))
        ROS_ERROR_STREAM("/talos_controller/base_directory parameter not found, needed for inria_wbc controller parameters");
      ROS_INFO_STREAM("Using base directory:" << base_directory_);
    }
  }

  // initialize the whole body controller from the yaml yaml_inria_wbc_ (from ros params)
  void JointController::initInriaWbc()
  {
    ROS_INFO_STREAM("main YAML file:" << base_directory_ + "/" + yaml_inria_wbc_);
    try
    {
      YAML::Node runtime_config = IWBC_CHECK(YAML::LoadFile(base_directory_ + "/" + yaml_inria_wbc_));
      auto behavior_yaml = IWBC_CHECK(runtime_config["iwbc_behavior"].as<std::string>());
      auto controller_yaml = IWBC_CHECK(runtime_config["iwbc_controller"].as<std::string>());
      ROS_INFO_STREAM("Using controller yaml:" << base_directory_ + "/" + controller_yaml);
      ROS_INFO_STREAM("Using behavior yaml:" << base_directory_ + "/" + behavior_yaml);

      auto controller_config = IWBC_CHECK(YAML::LoadFile(base_directory_ + "/" + controller_yaml));
      auto controller_base_path = controller_config["CONTROLLER"]["base_path"].as<std::string>();
      auto controller_robot_urdf = controller_config["CONTROLLER"]["urdf"].as<std::string>();
      controller_config["CONTROLLER"]["urdf"] = controller_base_path + "/" + controller_robot_urdf;

      ROS_INFO_STREAM("LOADING URDF MODEL FROM: " << controller_config["CONTROLLER"]["urdf"].as<std::string>());

      auto controller_name = IWBC_CHECK(controller_config["CONTROLLER"]["name"].as<std::string>());
      auto base_controller = inria_wbc::controllers::Factory::instance().create(controller_name, controller_config);
      controller_ = std::dynamic_pointer_cast<inria_wbc::controllers::PosTracker>(base_controller);
      IWBC_ASSERT(controller_, " We need at least a PostTracker!");

      auto behavior_config = IWBC_CHECK(YAML::LoadFile(base_directory_ + "/" + behavior_yaml));
      auto behavior_name = behavior_config["BEHAVIOR"]["name"].as<std::string>();
      behavior_ = inria_wbc::behaviors::Factory::instance().create(behavior_name, controller_, behavior_config);
      ROS_INFO_STREAM("Loaded behavior from factory " << behavior_name);

      // will be 0 / false if this is not a move behavior (in that case, no ROS topic/service)
      behavior_move_ = std::dynamic_pointer_cast<inria_wbc::behaviors::generic::Move>(behavior_);

      wbc_joint_names_ = controller_->controllable_dofs();
      init_sequence_duration_ = IWBC_CHECK(runtime_config["init_duration"].as<double>());
    }
    catch (std::exception &e)
    {
      ROS_ERROR_STREAM("TiagoController: Cannot init inria_wbc!" << e.what());
    }
  }

  bool JointController::initRequest(hardware_interface::RobotHW *robot_hw,
                                    ros::NodeHandle &root_nh, ros::NodeHandle &controller_nh, ClaimedResources &claimed_resources)
  {
    ROS_INFO("INIT REQUEST");

    hardware_interface::PositionJointInterface *position_iface =
        robot_hw->get<hardware_interface::PositionJointInterface>();

    if (!position_iface)
    {
      ROS_ERROR("This controller requires a hardware interface of type PositionJointInterface."
                " Make sure this is registered in the hardware_interface::RobotHW class.");
      return false;
    }

    position_iface->clearClaims();

    hardware_interface::VelocityJointInterface *velocity_iface =
        robot_hw->get<hardware_interface::VelocityJointInterface>();

    if (!velocity_iface)
    {
      ROS_ERROR("This controller requires a hardware interface of type VelocityJointInterface."
                " Make sure this is registered in the hardware_interface::RobotHW class.");
      return false;
    }
    velocity_iface->clearClaims();

    hardware_interface::JointStateInterface *joint_state_iface = robot_hw->get<hardware_interface::JointStateInterface>();
    if (!joint_state_iface)
    {
      ROS_ERROR("This controller requires a hardware interface of type '%s' ."
                " Make sure this is registered in the hardware_interface::RobotHW class.",
                hardware_interface::internal::demangledTypeName<hardware_interface::JointStateInterface>().c_str());
      return false;
    }

    if (!init(position_iface, velocity_iface, joint_state_iface, root_nh, controller_nh))
    {
      ROS_ERROR("Failed to initialize the controller");
      return false;
    }

    // Saves the resources claimed by this controller
    claimed_resources.push_back(hardware_interface::InterfaceResources(
        hardware_interface::internal::demangledTypeName<hardware_interface::PositionJointInterface>(),
        position_iface->getClaims()));
    position_iface->clearClaims();

    claimed_resources.push_back(hardware_interface::InterfaceResources(
        hardware_interface::internal::demangledTypeName<hardware_interface::VelocityJointInterface>(),
        velocity_iface->getClaims()));
    velocity_iface->clearClaims();

    claimed_resources.push_back(hardware_interface::InterfaceResources(
        hardware_interface::internal::demangledTypeName<hardware_interface::JointStateInterface>(),
        joint_state_iface->getClaims()));
    joint_state_iface->clearClaims();

    // Changes state to INITIALIZED
    state_ = INITIALIZED;

    ROS_INFO("INIT request OK");
    return true;
  }

  void JointController::update(const ros::Time &time, const ros::Duration &period)
  {
    if (!init_sequence_q_.empty())
    {
      for (int i = 0; i < wbc_joint_names_.size(); ++i)
        rc_joints_[i].setCommand(init_sequence_q_.front()[i]);
      init_sequence_q_.pop_front(); //slow but we don' t care here..
      if (init_sequence_q_.size() == 0)
        tts_client_->text_to_speech("Initialization done. Ready.");
    }
    else
    { // normal QP solver
      try
      {
        //ROS_INFO_STREAM("period:"<<period);// 100Hz on the robot, 1000 Hz in simu??
        behavior_->update(); //could have sensors here
      }
      catch (const std::exception &e)
      {
        ROS_ERROR_STREAM(e.what());
        stop_controller_ = true;
        return;
      }

      // send the commands
      if (!stop_controller_)
      {
        // careful: no auto here!
        Eigen::VectorXd q = controller_->q(false).tail(wbc_joint_names_.size());
        assert(rc_joint_.size() == q.size());
        for (size_t i = 0; i < wbc_joint_names_.size(); ++i)
          rc_joints_[i].setCommand(q[i]);
      } // we do nothing
      else
      {
        ROS_INFO("Tiago controller is stopped");
      }
    }

    // publish the poses (according to the model, not the robot!)
    pub_ee_.publish(se3_to_geometry(controller_->model_frame_pos("gripper_link")));
    pub_head_.publish(se3_to_geometry(controller_->model_frame_pos("head_2_link")));
  }

  void JointController::starting(const ros::Time &time)
  {
    ROS_INFO("Starting controller tiago_controller");
    tts_client_->text_to_speech("Starting controller.");

    initInriaWbc();
    stop_controller_ = false;

    // get the current position
    Eigen::VectorXd current_joint_pos = Eigen::VectorXd::Zero(wbc_joint_names_.size());
    for (size_t i = 0; i < wbc_joint_names_.size(); ++i)
      current_joint_pos[i] = rc_joint_states_[i].getPosition();
    ROS_INFO_STREAM("tiago_controller starting, joints=" << current_joint_pos.transpose());
    // minimum jerk initialization trajectory for init sequence
    auto q_v = trajectory_handler::compute_traj(
        current_joint_pos,
        controller_->q0(),
        controller_->dt(),
        init_sequence_duration_);
    init_sequence_q_ = std::list<Eigen::VectorXd>(q_v.begin(), q_v.end());
  }

  void JointController::stopping(const ros::Time &time)
  {
    ROS_INFO("Stopping controller tiago_controller");
    ROS_INFO("Stopping controller.");

    stop_controller_ = true;
  }

  // the pose message is here:http://docs.ros.org/en/noetic/api/geometry_msgs/html/msg/Pose.html
  // from command line: rosservice call /tiago_controller/move  "{pose: {position: {x: 0.5, y: 0.5, z: 1}}, duration: 1., use_orientation: False, task_name: ee }"

  bool JointController::move_service_cb(tiago_controller::move::Request &req, std_srvs::Empty::Response &res)
  {
    if (mode_ != TRAJ)
    {
      ROS_ERROR("ERROR [tiago_controller]: trying to send a trajectory in tracking mode! [traj ignored]");
      return false;
    }
    ROS_INFO_STREAM("Starting a trajectory (service) to" << req);
    tts_client_->text_to_speech("Moving!");

    auto target_pos = controller_->get_se3_ref("ee");
    // copy the position (and keep the orientation)
    target_pos.translation()(0) = req.pose.position.x;
    target_pos.translation()(1) = req.pose.position.y;
    target_pos.translation()(2) = req.pose.position.z;

    if (!behavior_move_)
    {
      ROS_ERROR_STREAM("WRONG behavior: we need a Move behavior to use the service move");
      return false;
    }

    try
    {
      behavior_move_->set_target(req.task_name, target_pos, req.duration);
    }
    catch (std::exception &e)
    {
      tts_client_->text_to_speech("Error when moving!");
      ROS_ERROR_STREAM("iwbc::exception:" << e.what());
      return false;
    }
    return true;
  }

  bool JointController::traj_mode_service_cb(std_srvs::Empty::Request &req, std_srvs::Empty::Response &res)
  {
    tts_client_->text_to_speech("Trajectory mode");
    mode_ = TRAJ;
    return true;
  }

  bool JointController::tracking_mode_service_cb(std_srvs::Empty::Request &req, std_srvs::Empty::Response &res)
  {
    tts_client_->text_to_speech("Tracking mode");
    mode_ = TRACKING;
    return true;
  }

  void JointController::set_target(const std::string& task_name, const geometry_msgs::Pose &pose)
  {
    if (mode_ != TRACKING)
    {
      ROS_WARN("Warning [tiago_controller]: trying to send tracking positions whereas in trajectory mode! [tracking ignored]");
      return;
    }
    // set the target
    if (!behavior_move_)
    {
      ROS_ERROR("WRONG behavior: we need a Move behavior to use the service move");
      return;
    }
    try
    {
      auto target_pos = geometry_to_se3(pose);
      behavior_move_->set_target(task_name, target_pos);
    }
    catch (std::exception &e)
    {
      tts_client_->text_to_speech("Error when setting target!");
      ROS_ERROR_STREAM("iwbc::exception:" << e.what());
      return;
    }
  }

  void JointController::tracking_ee_cb(const geometry_msgs::Pose &pose) {
    set_target("ee", pose);
  }

  void JointController::tracking_head_cb(const geometry_msgs::Pose &pose)
  {
    set_target("head", pose);
  }

}