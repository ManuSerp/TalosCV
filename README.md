# TalosCV






## Installation
### PySot


This document contains detailed instructions for installing dependencies for PySOT. We recommand using the install.sh. The code is tested on an Ubuntu 16.04 system with Nvidia GPU (We recommand 1080TI / TITAN XP). Go check https://github.com/STVIR/pysot.

#### Requirments
* Conda with Python 3.7.
* Nvidia GPU.
* PyTorch 0.4.1
* yacs
* pyyaml
* matplotlib
* tqdm
* OpenCV

#### Build extensions
```
python setup.py build_ext --inplace
```

### ROS

#### Requirements

ROS 1

openni2






## Launch:
```
Start roscore
Start openni2_launch
```
To launch the depth tracker first launch the depth printer and then the xtion tracker

```
./launch.sh 4 cmp
./launch.sh 3
```
docker

```
docker start `docker ps -q -l` && docker attach `docker ps -q -l`
```


# tiago_controller

https://gitlab.inria.fr/locolearn/tiago_controller

Tiago controller based on inria_wbc.

## References:
- manual for Tiago: https://gitlab.inria.fr/larsen-robots/tiago/-/tree/master/doc
- controller by Brice: https://gitlab.inria.fr/locolearn/tiago_controller/-/tree/master 
- controller for Talos: https://gitlab.inria.fr/locolearn/talos_controller 

## Usage (notes)

`./pal_docker.sh -it --name tiago registry.gitlab.inria.fr/locolearn/docker_talos/inria_wbc_pal:tiago -c terminator` 

#### Simulation

### compilation
- `source devel/setup.bash` 
- `catkin_make --only-pkg-with-deps tiago_controller` 

### Gazebo
- `source catkin_ws/devel/setup.bash`
- `roslaunch tiago_gazebo tiago_gazebo.launch public_sim:=true robot:=steel` 

### controller
- `source catkin_ws/devel/setup.bash` 
- `roslaunch tiago_controller tiago_controller.launch`

### Deployment
- `sh ./deploy.sh` 
- `say yes, passwd is 'pal'`
- `ssh pal@192.168.1.162 sync`
- if we added a new controller, we need to reboot the robot

- everything on the robot is on deployed_ws
- in pos_tracker.yaml : use the deployed_ws in the path
- in tiago_control.yaml: use deployed_ws
- check deployed_ws/share for the config files
- if we changed more than config files:

  - pal-stop deployer
  - pal-stop ros_bringup
  - pal-start ros_bringup
  - pal-start deployer

#### Starting/Stopping the controller
- `roslaunch tiago_controller tiago_controller.launch` 
- stop: ` rosrun controller_manager controller_manager stop tiago_controller`
rosrun controller_manager controller_manager stop tiago_controller




### Services and topics
There are two modes: trajectory and tracking. Tracking can make the robot too fast is the target is not close.
#### Topics
- `/tiago_controller/ee_pose` : pose of the end-effector according to the model (not the encoders)
- `/tiago_controller/ee_target` : write in this topic to publish a new position to track (TRACKING MODE only)
- `/tiago_controller/head_pose` : pose of the head (relative to the floating base)
- `/tiago_controller/head_target`: target for the head (warning: the tasks is likely to have a filter so that only the orientation can be changed)
#### Services
- `/tiago_controller/move`: move to a specific position using a trajectory (see example below) 
- `/tiago_controller/tracking_mode`: switch to tracking mode
- `/tiago_controller/traj_mode`: switch to trajectory mode




##### Examples
- `rosservice call /tiago_controller/move  "{pose: {position: {x: 0.5, y: 0.5, z: 1.2}}, duration: 1., use_orientation: False, use_position: True, task_name: ee}" ` 




