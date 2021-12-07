# 
# This is a Dockerfile for sandbox for base development librarises
# on Jetson Dev Kits
#

FROM ierturk/l4t-dev-ocv:latest

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    libwayland-client0 \
    libwayland-server0 \
    libglx-mesa0 \
    libegl1 \
    mesa-utils-extra \
    qtmultimedia5-examples \
    qtquickcontrols2-5-examples \
    qtquickcontrols5-examples \
    qtvirtualkeyboard5-examples \
    qtwayland5-examples \
    qml-module-qtquick-controls2 \
    libv4l-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    # libavresample-dev \
    libudev-dev \
    libavcodec-extra \
    # qt5-default \
    # qtdeclarative5-dev \
    freeglut3 \
    freeglut3-dev \
    libjpeg-turbo8-dev \
    libusb-1.0-0-dev \
    libusb-dev \
    libevdev-dev \
    libpulse-dev \
    qtmultimedia5-dev \
    # qtdeclarative5-window-plugin \
    qml-module-qtquick-controls \
    qml-module-qtquick-dialogs \
    qml-module-qtquick-extras \
    qml-module-qtquick-privatewidgets \
    # qtdeclarative5-qtquick2-plugin \
    libasound2-dev \
    libturbojpeg0-dev \
    qtquickcontrols5-doc \
    lsb-release \
    qtwayland5 \
    qml-module-qtwayland-compositor \
    qtwayland5-examples \
    libwayland-egl1-mesa \
    libwayland-egl1 \
    libqt5waylandclient5 \
    libqt5waylandcompositor5 \
    libqt5waylandclient5 \
    qml-module-* \
    libgstreamer1.0-0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    # gstreamer1.0-doc \
    gstreamer1.0-tools \
    gstreamer1.0-x \
    gstreamer1.0-alsa \
    gstreamer1.0-gl \
    gstreamer1.0-gtk3 \
    gstreamer1.0-qt5 \
    gstreamer1.0-pulseaudio \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    qt*-examples && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    qtdeclarative5-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# RUN sudo groupadd -g 19 input && \
#     sudo groupadd -g 988 render && \
#     usermod -aG input,render ierturk

RUN usermod -aG input,video,render,dialout ierturk
