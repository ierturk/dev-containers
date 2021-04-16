ARG VARIANT=20210212
FROM alpine:${VARIANT}

# [Option] Install zsh
ARG INSTALL_ZSH="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=ierturk
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY ./startup.sh /tmp/startup-scripts/
RUN apk update && ash /tmp/startup-scripts/startup.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" \
    && rm -rf /tmp/startup-scripts

# ** [Optional] Uncomment this section to install additional packages. **
# RUN apk update \
#     && apk add --no-cache <your-package-list-here>
