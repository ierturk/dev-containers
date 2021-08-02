ARG VARIANT="latest"
FROM docker.io/lopsided/archlinux:${VARIANT}

RUN pacman -Syyu --noconfirm --needed \
        git cmake pkg-config ninja repo\
        wget curl socat \
        sudo nano \
        && pacman -Scc --noconfirm

RUN pacman -Syyu --noconfirm --needed \
        base-devel \
        boost \
        nodejs-lts-fermium npm6 \
        && pacman -Scc --noconfirm

RUN npm install -g cmake-js \
        && npm cache clean --force

RUN rm /var/lib/pacman/sync/*
