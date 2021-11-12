$ cd ~/catkin_ws
$ source ./devel/setup.bash
$ source /opt/ros/noetic/setup.bash

demo track avec ros:

rosrun tracker_cam tracking.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth
