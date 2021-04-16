FROM ierturk/debian-dev-base:20210416-bullseye-00

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    make pkg-config cmake \
    gcc-arm-none-eabi binutils-arm-none-eabi gdb-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
    && apt-get clean -y && apt-get autoremove && rm -rf /var/lib/apt/lists/* 