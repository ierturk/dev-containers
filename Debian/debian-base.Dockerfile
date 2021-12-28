# [Choice] Debian version (use bullseye or stretch on local arm64/Apple Silicon): bullseye, buster, stretch
ARG VARIANT="bullseye"
FROM buildpack-deps:${VARIANT}-curl

# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="true"
# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=ierturk
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY script-library/*.sh script-library/*.env /tmp/library-scripts/
RUN bash /tmp/library-scripts/common-debian.sh "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
