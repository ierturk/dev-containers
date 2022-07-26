# 
# This is a Dockerfile for L4T Wayland Server
#

FROM ierturk/debian-base:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        weston \
        xwayland xdotool \
        mesa-utils-extra kbd v4l-utils \
        dos2unix \
        libqt5opengl5 \
        libqt5quick5-gles \
        libqt5quickparticles5-gles \
        libqt5concurrent5 \
        libqt5dbus5 \
        libqt5network5 \
        libqt5printsupport5 \
        libqt5sql5 \
        libqt5test5 \
        libqt5widgets5 \
        libqt5xml5 \
        libqt5qml5 \
        libqt5quicktest5 \
        libqt5quickwidgets5 \
        qml-module-qt-labs-qmlmodels \
        qml-module-qtqml-models2 \
        qml-module-qtquick-layouts \
        qml-module-qtquick-localstorage \
        qml-module-qtquick-particles2 \
        qml-module-qtquick-shapes \
        qml-module-qttest \
        qtwayland5 \
        qtwayland5-examples \
        libwayland-client0 \
        libwayland-server0 \
        libglx-mesa0 \
        libegl1 \
        mesa-utils-extra \
        qml-module-qtquick-virtualkeyboard \
    && rm -rf /var/lib/apt/lists/* && \
    apt-get clean

COPY assets/wayland/weston-entry.sh /usr/bin/entry.sh
COPY assets/wayland/weston.ini /etc/xdg/weston/weston.ini
COPY assets/wayland/weston-dev.ini /etc/xdg/weston-dev/weston.ini
# COPY assets/wayland/kms.conf /etc/kms.conf

ENV QT_QPA_PLATFORM="wayland"

# EGLFS configuration
# ENV QT_QPA_EGLFS_INTEGRATION="eglfs_kms"
# ENV QT_QPA_EGLFS_KMS_ATOMIC="1"
# ENV QT_QPA_EGLFS_KMS_CONFIG="/etc/kms.conf"