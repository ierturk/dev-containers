# 
# This is a Dockerfile for building OpenCV debian packages
# with CUDA, cuDNN, GStreamer, ect enabled.  You can then take
# the output .deb packages and install them into other containers.
#

FROM ierturk/l4t-dev-base:latest

USER root

#
# setup environment
#
ENV DEBIAN_FRONTEND=noninteractive
ENV CUDA_HOME="/usr/local/cuda"
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gfortran \
        cmake \
        git \
        file \
        tar \
        python3-pip \
        python3-dev \
        python3-numpy \
        python3-distutils \
        python3-setuptools \
        libatlas-base-dev \
        libavcodec-dev \
        libavformat-dev \
        libavresample-dev \
        libcanberra-gtk3-module \
        libdc1394-22-dev \
        libeigen3-dev \
        libglew-dev \
        libgstreamer-plugins-base1.0-dev \
        libgstreamer-plugins-good1.0-dev \
        libgstreamer1.0-dev \
        libgtk-3-dev \
        libjpeg-dev \
        libjpeg8-dev \
        libjpeg-turbo8-dev \
        liblapack-dev \
        liblapacke-dev \
        libopenblas-dev \
        libpng-dev \
        libpostproc-dev \
        libswscale-dev \
        libtbb-dev \
        libtbb2 \
        libtesseract-dev \
        libtiff-dev \
        libv4l-dev \
        libxine2-dev \
        libxvidcore-dev \
        libx264-dev \
        libgtkglext1 \
        libgtkglext1-dev \
        pkg-config \
        qv4l2 \
        v4l-utils \
        v4l2ucp \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
    
# Set as default user
USER ierturk
WORKDIR /home/ierturk

CMD ["bash"]
