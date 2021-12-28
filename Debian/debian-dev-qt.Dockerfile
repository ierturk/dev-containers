# 
# This is a Dockerfile for DEBIAN-DEV-BASE
#

FROM ierturk/debian-dev-base:latest

ARG DEBIAN_FRONTEND=noninteractive

#
# Qt Tools
#

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
    qtcreator \
    qtbase5-dev \
    qt*-dev-tools \
    qt*-examples \
    qt*-doc-html \
    qml-module-qt* \
    qtwayland5-dev-tools \
    qtwayland5 \
    qtmultimedia5-dev \
    qtdeclarative5-dev \
    qtquickcontrols2-5-dev \
    libopencv-core-dev \
    libopencv-contrib-dev \
    libopencv-*-dev \
    libfmt-dev \
    gstreamer1.0-plugins-good \
    v4l-utils \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
