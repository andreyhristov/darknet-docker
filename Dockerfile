ARG CUDA_VERSION=10.0
ARG UBUNTU_VERSION=18.04

FROM nvidia/cuda:$CUDA_VERSION-cudnn7-devel-ubuntu$UBUNTU_VERSION

RUN \   
        apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
                libopencv-dev \ 
                curl \
                wget \
                git \
                build-essential \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir /work
WORKDIR /work

RUN git clone https://github.com/prabindh/darknet.git \
    && cd darknet \
    && make darknet-cpp-shared \
    && cp libdarknet-cpp-shared.so ../ \
