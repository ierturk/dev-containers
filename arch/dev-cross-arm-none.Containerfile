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

ARG USERNAME=ierturk
RUN useradd -ms /bin/bash ${USERNAME} \
        && usermod -aG dialout ${USERNAME} \
        && echo ${USERNAME} ' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USERNAME}

RUN git config --global user.name "Ibrahim ERTURK" \
        && git config --global user.email "ierturk@ieee.org"

WORKDIR /home/${USERNAME}
