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

RUN  conda install -c pytorch pytorch torchvision -y