# 
# This is a Dockerfile for building Qt5 debian packages
#

FROM ierturk/l4t-dev-ocv:latest

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN cd /root && rm -rf *

# Get the basic stuff
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y \
        ninja-build \
    && apt-get clean -y && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# Set as default user
USER ierturk
WORKDIR /home/ierturk

ENV DEBIAN_FRONTEND teletype

CMD ["/bin/bash"]