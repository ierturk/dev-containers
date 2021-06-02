ARG VARIANT="15.3"
FROM opensuse/leap:${VARIANT}

RUN zypper --non-interactive ref \
        && zypper --non-interactive in git cmake pkg-config ninja \
            wget curl socat \
            libncurses5 \
            sudo nano bzip2 tar \
        && zypper --non-interactive clean -a


        
RUN wget -P /var/tmp https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 \
        && tar -xf /var/tmp/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 -C /opt
ENV PATH="/opt/gcc-arm-none-eabi-10-2020-q4-major/bin:${PATH}"

ARG USERNAME=ierturk
RUN useradd -ms /bin/bash ${USERNAME}
RUN usermod -aG dialout ${USERNAME}
RUN echo ${USERNAME} ' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USERNAME}
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo

RUN git config --global user.name "Ibrahim ERTURK"
RUN git config --global user.email "ierturk@ieee.org"

WORKDIR /home/${USERNAME}
