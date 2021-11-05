FROM timongentzsch/l4t-ubuntu20-base

ENV DEBIAN_FRONTEND noninteractive

# Get the basic stuff
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y \
    sudo \
    pkg-config cmake ninja-build \
    build-essential libopencv-dev python3-opencv \

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
