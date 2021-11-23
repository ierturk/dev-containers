# 
# This is a Dockerfile for Wayland Display Server
#

ARG BASE_IMAGE=ierturk/l4t-base:latest
FROM ${BASE_IMAGE}

USER root

# Wayland install
RUN apt-get -y update && apt-get install -y --no-install-recommends \
    libwayland-client0 \
    libwayland-server0 \
    libglx-mesa0 \
    libegl1 \
    mesa-utils-extra \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# Make sure the user can access DRM and video devices
RUN usermod -a -G video,render ierturk

ENV WAYLAND_USER="ierturk"
ENV XDG_RUNTIME_DIR="/tmp/1000-runtime-dir"
ENV WAYLAND_DISPLAY="wayland-0"
ENV DISPLAY=":0"
