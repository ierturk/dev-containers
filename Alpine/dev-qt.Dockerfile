ARG VARIANT=latest
FROM ierturk/alpine-dev-cpp:${VARIANT}

RUN apk update \
    && apk add --no-cache \
    qt5-qtbase-dev \ 
    qt5-qtwayland-dev \
    qt5-qtmultimedia-dev \
    qt5-qtdeclarative-dev \
    qt5-qtquickcontrols2-dev \
    opencv-dev \
    fmt-dev \
    gstreamer-tools \
    gst-plugins-good \
    gst-plugins-bad \
    v4l-utils

RUN getent group input || groupadd -g 19 input && \
    getent group render || groupadd -g 988 render && \
    groupmod -g 44 video && \
    usermod -aG video,dialout,input,render ierturk