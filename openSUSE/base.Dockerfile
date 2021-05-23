ARG VARIANT="15.3"
FROM opensuse/leap:${VARIANT}

RUN zypper --non-interactive ref \
        && zypper --non-interactive in -t pattern devel_C_C++ \
        && zypper --non-interactive in cmake pkg-config nodejs14 npm14 \
            cross-arm-binutils cross-arm-gcc7 python3 python3-pip \
        && zypper --non-interactive clean -a

ARG USERNAME=ierturk
RUN useradd -ms /bin/bash ${USERNAME}
RUN usermod -aG dialout ${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}
