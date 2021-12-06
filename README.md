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



# Install Docker

Follow the instructions [here](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) to install Docker.  

then [here](https://docs.docker.com/engine/installation/linux/linux-postinstall/) to configure your user group docker.  

Be sure that your ssh key are set so you can pull on inria repositories and github.  

# Images available

PLEASE KEEP THOSE IMAGES INTERNAL FOR NOW

Pal original docker image :

```
registry.gitlab.inria.fr/locolearn/docker_talos/pal:latest
```


Pal original docker image with the  robot_framework installed and integrated :
```
docker pull registry.gitlab.inria.fr/locolearn/docker_talos/talos:opensot
```



# Get an image built (Easy way)

You can use [Container Registry](https://gitlab.inria.fr/locolearn/docker_talos/container_registry) of our GitLab to get an image with the robot_framework for OpenSot.  
First login with :

```
docker login registry.gitlab.inria.fr
```

Then pull image :  

```
docker pull registry.gitlab.inria.fr/locolearn/docker_talos/talos:opensot
```

# Run your Docker :  

```
sudo chmod +x pal_docker.sh
./pal_docker.sh talos:opensot terminator
```

# Build manually your Docker :  

Go inside docker folder, you should have a __Makefile__, then run in a terminal :  

```make build```  

If you are starting it from scratch it will take time (20 min atleast).

The  __Makefile__ is pointing to specific git commits, it should also work at any time with the latest commits

If you have any issue ask me at eloise.dalin@inria.fr  


# Notes on installing libtorch [c++] (not automated)
First, we need to get the exact same nvidia driver as the host in the docker. You can check your driver by running `sudo modinfo nvidia` on your computer (not on the docker).

## Setup the apt repositories from nvidia
```

export DEBIAN_FRONTEND=noninteractive

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-ubuntu1604.pin
sudo mv cuda-ubuntu1604.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda

sudo mkdir /usr/lib/nvidia
```

### Install the driver
```
sudo apt-get -yq install nvidia-418=418.67-0ubuntu1
```

Check that it works with `nvidia-smi`

### Install pytorch (python!)
```
apt-get install unzip  python3-pip        
sudo apt-get install cuda-10-0 # be careful with the version here: older or equal than the computer
sudo apt-get -yq install nvidia-418=418.67-0ubuntu1
sudo apt-get install libcudnn8-dev 

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
. .bashrc
```
To test: import torch in a python3

### Install libtorch (be careful witht the cuda version in the name, here 110)
```
wget https://download.pytorch.org/libtorch/cu110/libtorch-cxx11-abi-shared-with-deps-1.7.0%2Bcu110.zip
unzip libtorch-cxx11-abi-shared-with-deps-1.7.0%2Bcu110.zip
```

To test:
```

git clone https://github.com/pytorch/examples.git
cd examples/cpp/dcgan

cmake ..  -DCMAKE_PREFIX_PATH=/home/user/libtorch
```
