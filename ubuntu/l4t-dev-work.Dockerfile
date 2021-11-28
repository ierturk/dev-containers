# 
# This is a Dockerfile for sandbox for base development librarises
# on Jetson Dev Kits
#

FROM ierturk/l4t-dev-libs:latest
    
# Set as default user
USER ierturk
WORKDIR /home/ierturk

CMD ["bash"]
