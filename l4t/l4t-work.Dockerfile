# 
# This is a Dockerfile for sandbox for base development libraries
# on Jetson Dev Kits
#

FROM ierturk/l4t-work:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openssh-server gdb && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN echo 'ierturk:pass' | chpasswd && \
    service ssh start

# CMD ["/usr/sbin/sshd", "-p", "2222", "-D"]

# Set as default user
USER ierturk
WORKDIR /home/ierturk

CMD ["bash"]

