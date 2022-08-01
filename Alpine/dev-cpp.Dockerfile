ARG VARIANT=latest
FROM ierturk/alpine-dev-base:${VARIANT}

RUN apk update \
    && apk add --no-cache \
    build-base \
    alpine-sdk \
    cmake \
    cppcheck \
    valgrind \
    clang \
    lldb \
    llvm \
    gdb \
    samurai \
    flex \
    bison
