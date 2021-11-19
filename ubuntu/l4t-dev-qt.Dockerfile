FROM ierturk/l4t-dev-ocv:latest

ENV DEBIAN_FRONTEND noninteractive

RUN cd /root && rm -rf *

# Get the basic stuff
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y \
        sudo \
        ninja-build \
        libfmt-dev qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev \
        qml-module-qtquick-* qml-module-qtmultimedia \
        libqt5multimedia5 libqt5multimedia5-plugins \
        libqt5multimediagsttools5 libqt5multimediaquick5 \
        libqt5multimediawidgets5 gstreamer1.0-qt5 \
        gstreamer1.0-plugins-good \
        libv4l-dev libavcodec-dev libavformat-dev \
        libavutil-dev libswscale-dev \
        libudev-dev libavcodec-extra \
        freeglut3 freeglut3-dev \
        libjpeg-turbo8-dev libusb-1.0-0-dev libusb-dev \
        libevdev-dev libpulse-dev \
        libasound2-dev libturbojpeg0-dev lsb-release \
        qtbase5-private-dev libqt5websockets5-dev \

    && apt-get clean -y && apt-get autoremove && rm -rf /var/lib/apt/lists/*

#
# webgl
#
RUN git clone https://github.com/qt/qtwebglplugin

RUN cd qtwebglplugin && \
    mkdir build && \
    cd build && \
    qmake .. && \
    make && \
    cp plugins/platforms/libqwebgl.so /usr/lib/aarch64-linux-gnu/qt5/plugins/platforms/ && \
    cd /root && \
    rm -rf qtwebglplugin

# Create ubuntu user with sudo privileges
RUN useradd -ms /bin/bash ierturk && \
    usermod -aG sudo ierturk
# New added for disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set as default user
USER ierturk
WORKDIR /home/ierturk

ENV DEBIAN_FRONTEND teletype

CMD ["/bin/bash"]