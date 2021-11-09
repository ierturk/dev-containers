FROM ierturk/l4t-cc:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG OPEN_CV_VERSION=4.5.4

### TODO: Add multistagebuild with crosscompile image ###

# 
# install opencv deps
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev \
    libgtk2.0-dev libcanberra-gtk* \
    python3-dev python3-numpy python3-pip \
    libxvidcore-dev libx264-dev libgtk-3-dev \
    libtbb2 libtbb-dev libdc1394-22-dev \
    gstreamer1.0-tools libv4l-dev v4l-utils \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    libavresample-dev libvorbis-dev libxine2-dev \
    libfaac-dev libmp3lame-dev libtheora-dev \
    libopencore-amrnb-dev libopencore-amrwb-dev \
    libopenblas-dev libatlas-base-dev libblas-dev \
    liblapack-dev libeigen3-dev gfortran \
    libhdf5-dev protobuf-compiler \
    libprotobuf-dev libgoogle-glog-dev libgflags-dev qt5-default \
    file && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN git clone --depth 1 https://github.com/opencv/opencv.git -b ${OPEN_CV_VERSION} && \
    git clone --depth 1 https://github.com/opencv/opencv_contrib.git -b ${OPEN_CV_VERSION}

# 
# build opencv debian packages from source.
# the generated .deb files will be found in release/*.deb .
# they will install opencv in /usr/local so it will not conflict with native ubuntu
# opencv installed version and will receive precedence with ld when loading opencv libraries
#
RUN cd opencv && \
    mkdir release && \
    cd release && \
    cmake -D CUDA_ARCH_BIN="7.2,5.3" \
          -D WITH_CUDA=ON \
          -D CUDA_ARCH_PTX="" \
          -D OPENCV_GENERATE_PKGCONFIG=ON \
          -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
          -D WITH_LIBV4L=ON \
          -D BUILD_opencv_python3=ON \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          -D BUILD_EXAMPLES=OFF \
          -D CMAKE_BUILD_TYPE=RELEASE \
          -D CPACK_BINARY_DEB=ON \
          -D CPACK_SET_DESTDIR=OFF \
          -D CPACK_PACKAGING_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && \
    make install && \
    make package

CMD ["bash"]
WORKDIR /root
