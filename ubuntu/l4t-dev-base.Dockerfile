# 
# This is a Dockerfile for building OpenCV debian packages
# with CUDA, cuDNN, GStreamer, ect enabled.  You can then take
# the output .deb packages and install them into other containers.
#
# See scripts/docker_build_opencv.sh to run it
#

ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.6.1
FROM ${BASE_IMAGE}

#
# setup environment
#
ENV DEBIAN_FRONTEND=noninteractive


# install sudo
RUN apt update && \
    apt install -y --no-install-recommends \
    sudo && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Create ubuntu user with sudo privileges
RUN useradd -ms /bin/bash ierturk && \
    usermod -aG sudo ierturk
# New added for disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set as default user
USER ierturk
WORKDIR /home/ierturk

CMD ["bash"]
