# 
# This is a Dockerfile for L4T-BASE
#

FROM ubuntu:bionic

ARG L4T_RELEASE_MAJOR=32.6
ARG L4T_RELEASE_MINOR=1
ARG CUDA=10.2
ARG DEBIAN_FRONTEND=noninteractive
ARG SOC="t210"

ARG L4T_RELEASE=$L4T_RELEASE_MAJOR.$L4T_RELEASE_MINOR

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils software-properties-common && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

#
# Jetson debian packages
#
RUN echo $L4T_RELEASE_MAJOR
ADD --chown=root:root https://repo.download.nvidia.com/jetson/jetson-ota-public.asc /etc/apt/trusted.gpg.d/jetson-ota-public.asc
RUN chmod 644 /etc/apt/trusted.gpg.d/jetson-ota-public.asc && \
    apt-get update && apt-get install -y --no-install-recommends ca-certificates && \
    echo "deb https://repo.download.nvidia.com/jetson/common r$L4T_RELEASE_MAJOR main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list && \
    echo "deb https://repo.download.nvidia.com/jetson/${SOC} r$L4T_RELEASE_MAJOR main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Create container user with sudo privileges
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo nano && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN useradd -ms /bin/bash ierturk && \
    usermod -aG sudo ierturk
# New added for disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set as default user
USER ierturk
WORKDIR /home/ierturk

CMD ["bash"]
