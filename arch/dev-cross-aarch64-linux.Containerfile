ARG VARIANT="latest"
FROM docker.io/lopsided/archlinux:${VARIANT}

RUN pacman -Syyu --noconfirm --needed \
        git cmake pkg-config ninja repo\
        wget curl socat \
        sudo nano \
        && pacman -Scc --noconfirm

RUN pacman -Syyu --noconfirm --needed \
        aarch64-linux-gnu-binutils \
        aarch64-linux-gnu-gcc \
        aarch64-linux-gnu-gdb \
        aarch64-linux-gnu-glibc \
        && pacman -Scc --noconfirm

RUN rm /var/lib/pacman/sync/*
