# 
# This is a Dockerfile for L4T-DEV-BASE
#

FROM ierturk/l4t-base:latest

ARG DEBIAN_FRONTEND=noninteractive

USER root

#
# Build tools
#

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    weston \
    xwayland xdotool \
    mesa-utils-extra kbd \
    dos2unix && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN sudo groupadd -g 19 input && \
    sudo groupadd -g 988 render && \
    usermod -aG input,render ierturk

COPY assets/weston/weston-entry.sh /usr/bin/entry.sh
COPY assets/weston/weston.ini /etc/xdg/weston/weston.ini
COPY assets/weston/weston-dev.ini /etc/xdg/weston-dev/weston.ini

# Set as default user
USER ierturk
WORKDIR /home/ierturk

# CMD ["bash"]
ENTRYPOINT ["/usr/bin/entry.sh"]