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
        && npm clean cache --force

ARG USERNAME=ierturk
RUN useradd -ms /bin/bash ${USERNAME} \
        && usermod -aG dialout ${USERNAME} \
        && echo ${USERNAME} ' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USERNAME}

RUN git config --global user.name "Ibrahim ERTURK" \
        && git config --global user.email "ierturk@ieee.org"

WORKDIR /home/${USERNAME}
