ARG ALPINE_VERSION=3.16
FROM alpine:${ALPINE_VERSION}

ENV USER="vnc-user" \
    APK_ADD="mesa-dri-swrast openssl socat sway xkeyboard-config" \
    APK_DEL="bash curl" \
    VNC_LISTEN_ADDRESS="0.0.0.0" \
    VNC_AUTH_ENABLE="false" \
    VNC_KEYFILE="key.pem" \
    VNC_CERT="cert.pem" \
    VNC_PASS="$(pwgen -yns 8 1)"

RUN apk update \
    && apk upgrade

# Add packages
RUN apk add --no-cache $APK_ADD

# Add fonts
RUN apk add --no-cache msttcorefonts-installer fontconfig \
    && update-ms-fonts

# Add application user
RUN addgroup -S $USER && adduser -S $USER -G $USER -G abuild

# Iinstall vnc packages
RUN apk add --no-cache wayvnc neatvnc

# Copy sway config
COPY assets/swayvnc/config /etc/sway/config

# Add wayvnc to compositor startup and put IPC on the network
RUN mkdir /etc/sway/config.d \
    && echo "exec wayvnc 0.0.0.0 5900" >> /etc/sway/config.d/exec \
    && echo "exec \"socat TCP-LISTEN:7023,fork UNIX-CONNECT:/tmp/sway-ipc.sock\"" >> /etc/sway/config.d/exec \
    && mkdir -p /home/$USER/.config/wayvnc/ \
    && printf "\
address=$VNC_LISTEN_ADDRESS\n\
enable_auth=$VNC_AUTH_ENABLE\n\
username=$USER\n\
password=$VNC_PASS\n\
private_key_file=/home/$USER/$VNC_KEYFILE\n\
certificate_file=/home/$USER/$VNC_CERT" > /home/$USER/.config/wayvnc/config

# Generate certificates vor VNC
RUN openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
	-keyout key.pem -out cert.pem -subj /CN=localhost \
	-addext subjectAltName=DNS:localhost,DNS:localhost,IP:127.0.0.1

# Add entrypoint
USER $USER
COPY assets/swayvnc/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
