# 
# This is a Dockerfile for building OpenCV debian packages
# with CUDA, cuDNN, GStreamer, ect enabled.  You can then take
# the output .deb packages and install them into other containers.
#

FROM ierturk/l4t-dev-cuda:latest

USER root

#
# setup environment
#

COPY assets/apt/opencv-4.5.4/*.deb ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ./OpenCV-4.5.4-aarch64-* \
    && rm *.deb \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
