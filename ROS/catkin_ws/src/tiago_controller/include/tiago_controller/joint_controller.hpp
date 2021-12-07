#ifndef TIAGO_JointController_HPP_
#define TIAGO_JointController_HPP_

#include <eigen3/Eigen/Core>

#include <ros/ros.h>
#include <std_msgs/Float64MultiArray.h>
#include <controller_interface/controller.h>
#include <hardware_interface/joint_command_interface.h>
#include <pluginlib/class_list_macros.h>
#include <std_srvs/Empty.h>
#include <geometry_msgs/Pose.h>

#include <boost/bind.hpp>
#include <chrono>
#include <iostream>
#include <map>
#include <memory>
#include <string>
#include <thread>
#include <vector>

// custom ROS messages
// for service
#include <tiago_controller/move.h>

// inria_wbc
#include <inria_wbc/behaviors/behavior.hpp>
#include <inria_wbc/controllers/pos_tracker.hpp>
#include "tiago_controller/behavior_move.hpp"
#include "tiago_controller/tts_client.hpp"

namespace tiago_controller
{
    class JointController : public controller_interface::ControllerBase
    {
    public:
        JointController() { ROS_INFO("tiago_controller::constructor"); }
        ~JointController() {}
        void update(const ros::Time &time, const ros::Duration &period);

        bool initRequest(hardware_interface::RobotHW *robot_hw, ros::NodeHandle &root_nh,
                         ros::NodeHandle &controller_nh, ClaimedResources &claimed_resources) override;
        // std::string getHardwareInterfaceType() const override;

        void starting(const ros::Time &time) override;
        void stopping(const ros::Time &time) override;

    private:
        bool init(hardware_interface::PositionJointInterface *position_iface,
                  hardware_interface::VelocityJointInterface *velocity_iface,
                  hardware_interface::JointStateInterface *joint_iface,
                  ros::NodeHandle &root_nh, ros::NodeHandle &control_nh);
        void readParametersROS(ros::NodeHandle &controller_nh);

        void initInriaWbc();

        // callbacks
        bool move_service_cb(tiago_controller::move::Request& req, std_srvs::Empty::Response &res);
        bool traj_mode_service_cb(std_srvs::Empty::Request& req, std_srvs::Empty::Response &res);
        bool tracking_mode_service_cb(std_srvs::Empty::Request& req, std_srvs::Empty::Response &res);
        void tracking_ee_cb(const geometry_msgs::Pose& pose);
        void tracking_head_cb(const geometry_msgs::Pose& pose);
        void set_target(const std::string& task_name, const geometry_msgs::Pose& p);

        // inria_wbc
        std::string yaml_inria_wbc_;
        std::string base_directory_;

        std::vector<std::string> wbc_joint_names_;
        std::map<std::string, double> map_next_pos_;
        std::shared_ptr<inria_wbc::behaviors::Behavior> behavior_;
        std::shared_ptr<inria_wbc::behaviors::generic::Move> behavior_move_;
        
        std::shared_ptr<inria_wbc::controllers::PosTracker> controller_;
        inria_wbc::controllers::SensorData sensor_data_;
        bool stop_controller_ = false;
   
        // init sequence
        std::list<Eigen::VectorXd> init_sequence_q_;
        int init_sequence_duration_ = 1;
        
        // ros_control
        std::vector<hardware_interface::JointHandle> rc_joints_;
        std::vector<hardware_interface::JointStateHandle> rc_joint_states_;

        // ROS topics and services
        ros::ServiceServer service_move_;
        ros::ServiceServer service_traj_mode_;
        ros::ServiceServer service_tracking_mode_;
        ros::Subscriber sub_ee_tracking_; // subscriber for end-effector tracking
        ros::Subscriber sub_head_tracking_;// subscriber for head tracking
        ros::Publisher pub_ee_; // pose of the end-effector
        ros::Publisher pub_head_; // pose of the head

        // mode
        enum mode_t { TRAJ, TRACKING };
        mode_t mode_ = TRAJ;

        // text to speech
        std::shared_ptr<TextToSpeechClient> tts_client_;
    };

    template <typename Param>
    bool getParameter(std::string &myParamName, Param &myParam, ros::NodeHandle &controller_nh)
    {
        std::string ns;
        // if you want to add a namespace concerning ROS parameters (optional)
        if (controller_nh.getParam("/namespace", ns))
            myParamName = ns + myParamName;

        if (!controller_nh.getParam(myParamName, myParam))
        {
            ROS_ERROR_STREAM("Can't read param " << myParamName);
            return false;
        }
        return true;
    }
} // namespace tiago_controller

PLUGINLIB_EXPORT_CLASS(tiago_controller::JointController, controller_interface::ControllerBase)

#endif // JointController_HPP_
