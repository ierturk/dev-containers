# 
# This is a Dockerfile for sandbox for base development libraries
# on Jetson Dev Kits
#

FROM ierturk/l4t-dev-work:latest

RUN apt-get -y update && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
        zbarcam-qt \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN usermod -aG input,video,render,dialout ierturk

ENV WAYLAND_USER=ierturk
ENV XDG_RUNTIME_DIR=/run/user/1000
ENV WAYLAND_DISPLAY=wayland-0
ENV DISPLAY=:0
# QT_QPA_PLATFORM=wayland
# - LIBGL_ALWAYS_INDIRECT=0
# - QT_QPA_PLATFORM=eglfs
# - QT_QPA_EGLFS_ALWAYS_SET_MODE=1
# - QT_LOGGING_RULES=qt.qpa.*=true
# - QT_LOGGING_RULES=qt.qpa.wayland.*=false
# - QT_QPA_EGLFS_INTEGRATION=eglfs_kms
# - QT_QPA_EGLFS_KMS_CONFIG=/workspace/kms.conf
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV OPENBLAS_CORETYPE=ARMV8

RUN ssh-keygen -A && mkdir -p /run/sshd

