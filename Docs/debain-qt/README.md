# Debain 11 Qt Development Containers #
This is how to build the `Docker Containers` for developing `Qt` especially with `VS Code` using `Remote Development Containers` or directly access by `ssh` runs wirhin container.
____
## Containers and its Derivatives ##
At first it should be cloned this repo as follow. The containers based on `Debian 11`.
```
$ cd ~/Work/PROj
$ git clone https://github.com/ierturk/dev-containers.git
```
### base ###
All of the containers is built from this base. It can be built as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/Debian/docker-compose-dev.yml work
```
### dev-base ###
Base development container includes `build-tools` for `C++`. It is built from `Base` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-base
```
### dev-qt ###
Base development container includes `Qt Dev Libraries`, `Qt Creator` and `OpenCV Dev Libraries`. It is built from `Dev-Base` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-qt
```
### dev-work ###
It is just working container and it can be added extra packages in case of it need tobe extra libraries such as `open-ssh server`. It is built from `Dev-Qt` Container as follow.
```
$ docker-compose build -f ~/Work/PROJs/dev-containers/l4t/docker-compose-dev.yml dev-work
```
### app ###
It is not directly built. It is just a taken `snapshot` from a running `Dev-Work` container as follow. 
```
$ docker commit l4t_debain-dev-app_1 ierturk ierturk/l4t-app:latest
```
The containers are alredy pushed into `Docker Hub` and can be pulled from there.
___
Copyright © 2021 StarGate, Inc.

