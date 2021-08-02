ARG VARIANT="latest"
FROM docker.io/archlinux:${VARIANT}

RUN pacman -Syyu --noconfirm \
        git cmake pkg-config ninja repo\
        wget curl socat nano \
        && pacman -Scc --noconfirm

RUN pacman -Syyu --noconfirm \
        arm-none-eabi-binutils \
        arm-none-eabi-gcc \
        arm-none-eabi-gdb \
        arm-none-eabi-newlib \
        && pacman -Scc --noconfirm
        