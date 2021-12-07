#include "tiago_controller/behavior_move.hpp"

namespace inria_wbc
{
    namespace behaviors
    {
        namespace generic
        {
            static Register<Move> __talos_move_arm("generic::move");

            Move::Move(const controller_ptr_t &controller, const YAML::Node &config)
                : Behavior(controller, config)
            {
                auto c = IWBC_CHECK(config["BEHAVIOR"]);

                behavior_type_ = this->behavior_type();
                controller_->set_behavior_type(behavior_type_);

                pos_tracker_ = std::static_pointer_cast<inria_wbc::controllers::PosTracker>(controller_);

                auto workspace = IWBC_CHECK(c["workspace"]);
                for (auto it = workspace.begin(); it != workspace.end(); ++it)
                {
                    auto task_name = IWBC_CHECK(it->first.as<std::string>());
                    using pair_t = std::pair<double, double>;
                    auto x = IWBC_CHECK(it->second["x"].as<pair_t>());
                    auto y = IWBC_CHECK(it->second["y"].as<pair_t>());
                    auto z = IWBC_CHECK(it->second["z"].as<pair_t>());
                    workspaces_[task_name] = {x, y, z};
                }
                auto tracking_limit = IWBC_CHECK(c["tracking_limit"]);
                for (auto it = tracking_limit.begin(); it != tracking_limit.end(); ++it)
                {
                    auto task_name = IWBC_CHECK(it->first.as<std::string>());
                    tracking_limits_[task_name] = it->second.as<double>();
                }
            }

            pinocchio::SE3 Move::put_in_workspace(const pinocchio::SE3 &point, const std::string &task_name)
            {
                if (workspaces_.find(task_name) == workspaces_.end())
                    return point;

                // filter by the workspace
                auto range = [](double x, const std::pair<double, double> &min_max)
                {
                    return std::max(min_max.first, std::min(x, min_max.second));
                };
                pinocchio::SE3 p = point;
                p.translation()(0) = range(p.translation()(0), workspaces_[task_name].x);
                p.translation()(1) = range(p.translation()(1), workspaces_[task_name].y);
                p.translation()(2) = range(p.translation()(2), workspaces_[task_name].z);
                return p;
            }

            void Move::set_target(const std::string &task_name, const pinocchio::SE3 &target, float duration)
            {
                // we assume that the target is valid (needs to be checked from outside!)
                auto task_init = pos_tracker_->get_se3_ref(task_name);
                auto pts = trajectory_handler::compute_traj(task_init, target, controller_->dt(), duration);

                for (auto &p : pts)
                    p = put_in_workspace(p, task_name);

                // assign the trajectory
                trajectories_[task_name] = {.points = pts, .time = 0};
            }

            void Move::set_target(const std::string &task_name, const pinocchio::SE3 &target)
            {
                auto current_ref = pos_tracker_->get_se3_ref(task_name);
                double dist = (current_ref.translation() - target.translation()).norm();
                if (dist >= tracking_limits_[task_name])
                    throw IWBC_EXCEPTION("Move :: tracking mode: distance exceed limit! d=",
                                         dist, " max=", tracking_limits_[task_name]);
                targets_[task_name] = put_in_workspace(target, task_name);
            }

            void Move::update(const controllers::SensorData &sensor_data)
            {
                // trajectories have the top priority.
                for (auto &t : targets_)
                {
                    if (trajectories_.find(t.first) != trajectories_.end())
                        continue; // skip this if there is a trajectory
                    pos_tracker_->set_se3_ref(t.second, t.first);
                }

                // now trajectories refs
                for (auto it = trajectories_.begin(); it != trajectories_.end(); /*nothing*/)
                {
                    auto &traj = it->second;
                    IWBC_ASSERT(!traj.points.empty(), "invalid trajectory (empty)");
                    pos_tracker_->set_se3_ref(traj.points[traj.time], it->first);
                    traj.time++;

                    // increment or erase (end of trajectory)
                    if (traj.time == (int)traj.points.size())
                        it = trajectories_.erase(it);
                    else
                        it++;
                }
                controller_->update(sensor_data);
            }
        } // namespace generic
    }     // namespace behaviors
} // namespace inria_wbc