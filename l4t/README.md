# Jetson Nano Development Containers #
This is how to build the `Docker Container` for development on `Jetson Nano` with `nVidia-Runtime`. They can be built on a machine with `Docker` by `buildx` or directly on `Jetson Nano`.
____
## Containers and its Derivatives ##
At first it should be cloned this repo as follow.
```
$ cd ~/Work/PROj
$ git clone https://github.com/ierturk/dev-containers.git
```
### base ###
All of the containers is built from this base. It can be built as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml work
```
### dev-base ###
Base development container includes `build-tools`. The `GCC-8` is installed for `CUDA`. It is built from `Base` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-base
```
### wayland ###
The container will run as display server. It is built from `Base` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml wayland
```
### dev-cuda ###
It includes the `CUDA` development libraries. It is built from `Dev-Base` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-cuda
```
### dev-libs ###
It will be used for compiling the `OpenCV`. It is built from `Dev-Cuda` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-libs
```
### dev-ocv ###
It includes `OpenCV` `Debian` packages whis are previously compiled on `Dev-Libs`. It is built from `Dev-Cuda` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-ocv
```
### dev-work ###
It includes `Qt5-Dev` and the other `multimedia` libraries. It is built from `Dev-Ocv` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-work
```
### work ###
It includes `TensorRT`. It is built from `Dev-Work` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml work
```
### app ###
It is not directly built. It is just a taken `snapshot` from a running `Work` container as follow. 
```
$ docker commit l4t_app_1 ierturk ierturk/l4t-app:latest
```
The containers are alredy pushed into `Docker Hub` and can be pulled from there.
___

## The Libraries do not have debian packages ##
The `OpenCV` library  whis was build with `CUDA` and the `OnnxRunTime` with `TensorRT` providers are compiled from source as follow.
### OpenCV ###
The `OpenCV` library was built on `Dev-Libs` Container as follow.
```
>> Getting source
$ git clone --depth 1 --branch 4.5.4 https://github.com/opencv/opencv.git
$ git clone --depth 1 --branch 4.5.4 https://github.com/opencv/opencv_contrib.git
$ cd opencv
$ mkdir build
$ cd build
$ cmake \
        -D CPACK_BINARY_DEB=ON \
        -D BUILD_EXAMPLES=OFF \
        -D BUILD_opencv_python2=OFF \
        -D BUILD_opencv_python3=ON \
        -D BUILD_opencv_java=OFF \
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D CUDA_ARCH_BIN=5.3 \
        -D CUDA_ARCH_PTX= \
        -D CUDA_FAST_MATH=ON \
        -D CUDNN_INCLUDE_DIR=/usr/include \
        -D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
        -D WITH_EIGEN=ON \
        -D ENABLE_NEON=ON \
        -D OPENCV_DNN_CUDA=ON \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
        -D OPENCV_GENERATE_PKGCONFIG=ON \
        -D WITH_CUBLAS=ON \
        -D WITH_CUDA=ON \
        -D WITH_CUDNN=ON \
        -D WITH_GSTREAMER=ON \
        -D WITH_LIBV4L=ON \
        -D WITH_OPENCL=OFF \
        -D WITH_IPP=OFF \
        -D WITH_TBB=ON \
        -D BUILD_TIFF=ON \
        -D BUILD_PERF_TESTS=OFF \
        -D BUILD_TESTS=OFF \
        ../opencv
$ make -j4
$ make install
$ make package
$ cp *.deb ./assets
```
### OnnxRunTime ###
The `OnnxRunTime` library was built on `l4t-app` Container as follow. It needs tobe enabled `Linux Swap`. For more information to enable swap based on `Swap File` [follow this link][1].
```
$ ./build.sh \
        --cuda_home /usr/local/cuda \
        --cudnn_home /usr/lib/aarch64-linux-gnu/ \
        --use_tensorrt \
        --tensorrt_home /usr/lib/aarch64-linux-gnu/ \
        --config RelWithDebInfo \
        --build_shared_lib \
        --build_wheel \
        --skip_tests \
        --parallel
```
___
Copyright © 2021 StarGate, Inc.

[1]: https://www.howtogeek.com/455981/how-to-create-a-swap-file-on-linux/
        (Swap File Enable)