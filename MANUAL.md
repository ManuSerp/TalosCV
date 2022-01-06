# Manual

## Instruction to use TalosCV


### Installation
#### Requirements
// to fill up //

#### Pysot
First follow [Pysot](https://github.com/STVIR/pysot/blob/master/INSTALL.md) install instruction to configure the python environnement in order to run SiamNN

#### ROS

Install a ROS distrib

####  TalosCV

Simply clone this repo and in ROS/catkin do

```
catkin build
```

Install openni2 ROS package if necessary as a driver for the xtion

Now everythings is good to go


#### Tiago controller
to get the docker with the controller clone https://gitlab.inria.fr/locolearn/docker_talos.
Now run
```
./pal_docker.sh -it --name tiago registry.gitlab.inria.fr/locolearn/docker_talos/inria_wbc_pal:tiago -c terminator
```
in catkin ``` cd catkin```
```
catkin_make
```
then to install the controller
go to src ```cd src```

```
git clone https://gitlab.inria.fr/locolearn/tiago_controller.git
```
go back to catkin ``` cd ..```
```
catkin_make --only-pkg-with-deps tiago_controller
```
```
source devel/setup.bash
```

Now everything is ready to launch programs




### Launching Program
#### General

there some programs that can be launched without the docker 
to see the list of launchable scripts:
```
./launch.sh man
```
A ``` sudo chmod +x launch.sh``` may be necessary

If you only want to launch tracking scripts that dont need the robots you need to launch a ``` roscore ``` in another terminal.

#### To launch the tracking of a object trough th xtion with the robot arm in gazebo following the movement:
##### Docker
In the docker , in a first terminal launch gazebo:
```
roslaunch tiago_gazebo tiago_gazebo.launch public_sim:=true robot:=steel
```

Wait for the robots to take is resting place in gazebo and then launch the controller:

```
roslaunch tiago_controller tiago_controller.launch
```

the robot should go to a new resting place.

Gazebo is now ready to interact with the tracking programs

##### Outside
Open a terminal in the TalosCV/ROS/catkin folder
No need to launch a roscore as we will use the gazebo or robot roscore.

setup the terminal to interact with the docker:

- il faut d’abord trouver l’IP du docker (généralement 172.17.0.1 ou .2)
  - dans le docker, installer ifconfig : 
  ```
  apt-get install net-tools
  ```
  - puis ``` ifconfig -a ``` et regarder le champ ‘inet’ de docker0
- à l’extérieur du docker (changer l'ip si necessaire):
  - ``` export ROS_MASTER_URI=http://172.17.0.1:11311 ``` 
  - ``` export ROS_IP=172.17.0.1 ```
 Normalement un rostopic list en dehors du docker devrait lister les topics (si tout tourne dans le docker bien sûr).
Now launch the xtion driver
```
roslaunch openni2_launch openni2.launch
```
launch the depth printer
```
./launch.sh 4
```
and then launch the tracker
```
./launch.sh 3
```

***
# Documentation tiago controller



https://gitlab.inria.fr/locolearn/tiago_controller

Tiago controller based on inria_wbc.

## References:
- manual for Tiago: https://gitlab.inria.fr/larsen-robots/tiago/-/tree/master/doc
- controller by Brice: https://gitlab.inria.fr/locolearn/tiago_controller/-/tree/master 
- controller for Talos: https://gitlab.inria.fr/locolearn/talos_controller 

## Usage (notes)


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











