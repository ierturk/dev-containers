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
    build-essential \
    cmake \
    cppcheck \
    valgrind \
    clang \
    lldb \
    llvm \
    gdb \
    ninja-build \
    flex \
    bison \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
