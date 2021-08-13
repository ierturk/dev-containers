ARG VARIANT="latest"
FROM docker.io/lopsided/archlinux:${VARIANT}

RUN pacman -Syyu --noconfirm --needed \
        repo \
        sudo nano \
        && pacman -Scc --noconfirm \
        && rm /var/lib/pacman/sync/*