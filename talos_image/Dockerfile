ARG UBUNTU_VER=18.04
ARG CONDA_VER=latest
ARG OS_TYPE=x86_64
ARG PY_VER=3.9
ARG PANDAS_VER=1.3

FROM ubuntu:${UBUNTU_VER}
# System packages 
RUN apt-get update && apt-get install -yq curl wget jq vim

# Use the above args 
ARG CONDA_VER
ARG OS_TYPE
# Install anaconda to /anaconda
RUN curl -LO "https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh"
RUN bash Anaconda3-2021.11-Linux-x86_64.sh -p /anaconda -b
RUN rm Anaconda3-2021.11-Linux-x86_64.sh
ENV PATH=/anaconda/bin:${PATH}
RUN conda update -y conda
RUN conda init

ARG PY_VER
ARG PANDAS_VER
# Install packages from conda 
RUN conda install -c anaconda -y python=${PY_VER}
RUN conda install -c anaconda -y \
    pandas=${PANDAS_VER}

#git
RUN apt update
RUN apt-get install -y git
#pysot
RUN git clone https://github.com/STVIR/pysot.git
RUN conda update conda --all
RUN conda install numpy -y
RUN conda install pytorch torchvision cuda90 -c pytorch -y
RUN pip install opencv-python
RUN pip install pyyaml yacs tqdm colorama matplotlib cython tensorboardX 
RUN apt install build-essential -y
RUN cd pysot && python setup.py build_ext --inplace 



#ROS
RUN apt-get update
RUN apt-get install lsb-release -y
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update
ENV TZ=Europe/Berlin
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install ros-melodic-desktop-full -y

RUN echo "source /opt/ros/melodic/setup.bash" >> home/.bashrc
RUN /bin/bash -c "source home/.bashrc"

RUN apt-get install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential -y
RUN apt-get install python-rosdep -y
RUN rosdep init
RUN rosdep update
RUN apt-get install ros-melodic-catkin python-catkin-tools -y

# TalosCV
RUN git clone https://github.com/ManuSerp/TalosCV.git
RUN cd TalosCV/ROS/catkin_ws/ && catkin clean
RUN touch README.md && echo "do: catkin clean, change: cmake req version to 3.10 in CMAKElist, then: catkin build" >> README.md



