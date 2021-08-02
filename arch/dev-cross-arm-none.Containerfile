ARG VARIANT="latest"
FROM docker.io/lopsided/archlinux:${VARIANT}

RUN pacman -Syyu --noconfirm --needed \
        git cmake pkg-config ninja repo\
        wget curl socat \
        sudo nano \
        && pacman -Scc --noconfirm

RUN pacman -Syyu --noconfirm --needed \
        arm-none-eabi-binutils \
        arm-none-eabi-gcc \
        arm-none-eabi-gdb \
        arm-none-eabi-newlib \
        && pacman -Scc --noconfirm

RUN rm /var/lib/pacman/sync/*
