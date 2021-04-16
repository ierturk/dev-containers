FROM ierturk/alpine-dev-base:20210212

RUN apk update \
    && apk add --no-cache \
    make \
    cmake \
    gcc-arm-none-eabi gdb-multiarch