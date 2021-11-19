FROM ierturk/l4t-dev-ocv:latest

ENV DEBIAN_FRONTEND noninteractive

# Get the basic stuff
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y \
        sudo \
        ninja-build \
        libfmt-dev qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev \
        qml-module-qtquick-* qml-module-qtmultimedia \
        libqt5multimedia5 libqt5multimedia5-plugins \
        libqt5multimediagsttools5 libqt5multimediaquick5 \
        libqt5multimediawidgets5 gstreamer1.0-qt5 \
        gstreamer1.0-plugins-good \
    && apt-get clean -y && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# Create ubuntu user with sudo privileges
RUN useradd -ms /bin/bash ierturk && \
    usermod -aG sudo ierturk
# New added for disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set as default user
USER ierturk
WORKDIR /home/ierturk

ENV DEBIAN_FRONTEND teletype

CMD ["/bin/bash"]
