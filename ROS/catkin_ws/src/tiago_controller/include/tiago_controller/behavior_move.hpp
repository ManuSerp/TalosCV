#ifndef IWBC_BEHAVIOR_GENERIC_MOVE_HPP
#define IWBC_BEHAVIOR_GENERIC_MOVE_HPP
#include <chrono>
#include <iostream>
#include <signal.h>

#include <inria_wbc/behaviors/behavior.hpp>
#include <inria_wbc/controllers/pos_tracker.hpp>
#include <inria_wbc/utils/trajectory_handler.hpp>

namespace inria_wbc {
    namespace behaviors {
        namespace generic {
            class Move : public Behavior {
            public:
                Move(const controller_ptr_t& controller, const YAML::Node& config);
                Move() = delete;
                Move(const Move&) = delete;
                virtual ~Move() {}

                // this makes a trajectory
                void set_target(const std::string& task_name, const pinocchio::SE3& target, float duration);
                
                // this is as fast as possible (next time-step)
                void set_target(const std::string& task_name, const pinocchio::SE3& target);
                
                bool target_reached(const std::string& task_name) const {
                    // trajectories are removed once they have reached their last point
                    return trajectories_.find(task_name) != trajectories_.end();
                }
               
                void update(const controllers::SensorData& sensor_data = {}) override;
                std::string behavior_type() const override { return controllers::behavior_types::DOUBLE_SUPPORT; };

            private:
                pinocchio::SE3 put_in_workspace(const pinocchio::SE3& point, const std::string& task_name);
                struct Traj {
                    std::vector<pinocchio::SE3> points;
                    int time = 0;
                };
                struct Workspace {
                    std::pair<double, double> x; // min/max
                    std::pair<double, double> y; // min/max
                    std::pair<double, double> z; // min/max
                };
                std::shared_ptr<controllers::PosTracker> pos_tracker_;
                std::unordered_map<std::string, Traj> trajectories_;
                std::unordered_map<std::string, Workspace> workspaces_;
                std::unordered_map<std::string, pinocchio::SE3> targets_;
                std::unordered_map<std::string, double> tracking_limits_;
            };
        } // namespace generic
    } // namespace behaviors
} // namespace inria_wbc
#endif