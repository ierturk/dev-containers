ARG IMAGE_ARCH=linux/arm/v7
ARG IMAGE_FROM=debian
ARG IMAGE_TAG=bullseye-20210408-slim

FROM --platform=$IMAGE_ARCH $IMAGE_FROM:$IMAGE_TAG

# GDB-remote (we can use any port there)
EXPOSE 6502
EXPOSE 3000

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND="noninteractive"

# your regular RUN statements here
# Install required packages
RUN apt-get -q -y update \
    && apt-get -q -y install \
    nodejs npm yarnpkg emscripten git repo cmake pkg-config ninja-build python3-minimal python3-venv\
    \
    && rm -rf /var/lib/apt/lists/*

RUN usermod -a -G dialout ierturk

USER ierturk

RUN git config --global user.name "Ibrahim ERTURK"
RUN git config --global user.email "ierturk@ieee.org"

WORKDIR /app
# CMD /bin/bash
