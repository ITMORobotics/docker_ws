#!/bin/bash


if [[ $OSTYPE == 'darwin'* ]]; then
    echo 'Instaling on macOS'
    brew install  ca-certificates \
                curl \
                software-properties-common \
                docker-ce \
                docker-ce-cli \
                containerd.io \
                gnupg \
                gnupg2
    gpg --keyserver https://nvidia.github.io/nvidia-docker/gpgkey | --recv-keys D39DC0E3

else
    sudo apt update && sudo apt install -y apt-transport-https \
                                    ca-certificates \
                                    curl \
                                    gnupg-agent \
                                    software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo usermod -aG docker $USER

    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$(. /etc/os-release;echo $ID$VERSION_ID)/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
    sudo systemctl restart docker

    newgrp docker

fi