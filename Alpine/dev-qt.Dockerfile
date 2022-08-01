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
    gst-plugins-good \
    v4l-utils