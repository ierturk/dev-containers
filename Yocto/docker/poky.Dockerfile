FROM crops/poky:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc-8 g++-8 \
    libncurses5-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

USER usersetup