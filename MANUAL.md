# Manual

## Instruction to use TalosCV

### Installation

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

Now everything is ready to launch programs



### Launching Program
#### General
