# 
# This is a Dockerfile for L4T-DEV-BASE
#

FROM ierturk/l4t-base:latest

ARG DEBIAN_FRONTEND=noninteractive

#
# Build tools
#

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    gcc-8 g++-8 gdb \
    cmake git unzip pkg-config ninja-build \
    wget curl rsync \
    python3-dev python3-pip python3-numpy && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Required for cuda compiler
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
