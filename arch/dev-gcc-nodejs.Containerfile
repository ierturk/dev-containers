ARG VARIANT="latest"
FROM docker.io/archlinux:${VARIANT}

RUN pacman -Syyu --noconfirm \
        git cmake pkg-config ninja repo\
        wget curl socat nano \
        && pacman -Scc --noconfirm

RUN pacman -Syyu --noconfirm \
        base-devel \
        boost \
        nodejs-lts-fermium npm6 \
        && pacman -Scc --noconfirm

RUN npm install -g cmake-js \
        && npm cache clean --force
