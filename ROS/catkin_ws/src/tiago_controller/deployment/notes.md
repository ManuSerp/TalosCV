sh ./deploy.sh
say yes, passwd is 'pal' 
ssh pal@192.168.1.162 sync
reboot: using the 2 buttons

everything on the robot is on deployed_ws
in pos_tracker.yaml : use the deployed_ws in the path
in tiago_control.yaml: use deployed_ws

check deployed_ws/share for the config files

# to start
roslaunch tiago_controller tiago_controller.launch

stop our controller:
 rosrun controller_manager controller_manager stop tiago_controller

rosrun controller_manager controller_manager stop tiago_controller

pal-stop deployer
pal-stop ros_bringup

pal-start ros_bringup
pal-start deployer

