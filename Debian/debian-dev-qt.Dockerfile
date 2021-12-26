# 
# This is a Dockerfile for DEBIAN-DEV-BASE
#

FROM ierturk/debian-base:latest

ARG DEBIAN_FRONTEND=noninteractive

#
# Build tools
#

COPY script-library/meta.env /usr/local/etc/vscode-dev-containers
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
    qtbase5-dev \
    qtwayland5-dev-tools \
    qtquickcontrols2-5-dev \
    qtwayland5 \
    qtdeclarative5-examples \
    qtwayland5-examples \
    qtquickcontrols5-examples \
    qtquickcontrols2-5-examples \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN ssh-keygen -A && mkdir -p /run/sshd
