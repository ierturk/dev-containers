# 
# This is a Dockerfile for sandbox for base development librarises
# on Jetson Dev Kits
#

FROM ierturk/l4t-dev-libs:latest

USER root

RUN usermod -aG input,video,render,dialout ierturk

# Set as default user
USER ierturk
WORKDIR /home/ierturk

CMD ["bash"]
