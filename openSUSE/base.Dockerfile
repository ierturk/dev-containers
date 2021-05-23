ARG VARIANT="15.3"
FROM opensuse/leap:${VARIANT}

RUN zypper --non-interactive ref \
        && zypper --non-interactive in -t pattern devel_basis devel_C_C++ \
        && zypper --non-interactive in gcc-c++ git cmake pkg-config \
            libboost_headers1_66_0-devel libboost_date_time1_66_0-devel libboost_system1_66_0-devel \
            nodejs14 npm14 \
            cross-arm-binutils cross-arm-gcc7 python3 python3-pip \
            wget curl socat \
        && zypper --non-interactive clean -a

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN npm install -g cmake-js

ARG USERNAME=ierturk
RUN useradd -ms /bin/bash ${USERNAME}
RUN usermod -aG dialout ${USERNAME}

USER ${USERNAME}
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo

RUN git config --global user.name "Ibrahim ERTURK"
RUN git config --global user.email "ierturk@ieee.org"

WORKDIR /home/${USERNAME}
