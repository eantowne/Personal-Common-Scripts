#!/usr/bin/env bash

sudo apt-add-repository ppa:gns3/ppa -y
sudo apt install nfs-common python3-pip gns3-gui docker.io htop nvidia-driver-460-server nvidia-utils-460-server nvidia-compute-utils-460-server htop build-essential git libssl-dev zlib1g-dev yasm pkg-config libgmp-dev libpcap-dev libbz2-dev nvidia-opencl-dev
sudo usermod -aG docker ean
sudo reboot
