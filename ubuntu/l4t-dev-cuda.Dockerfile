# 
# This is a Dockerfile for L4T-DEV-BASE
#

FROM ierturk/l4t-dev-base:latest

ARG DEBIAN_FRONTEND=noninteractive

USER root

#
# nVidia cuda and cudnn dev packages
#

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cuda-toolkit-10-2 nvidia-cudnn8 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean
