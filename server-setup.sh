#!/usr/bin/env bash

echo 'Adding GNS3 PPA...'
apt-add-repository ppa:gns3/ppa -y > server-setup.log && echo 'GNS3 PPA: [COMPLETE]'

echo 'Installing required Packages'
apt install -y nfs-common python3-pip gns3-server docker.io htop nvidia-headless-460-server htop build-essential git libssl-dev zlib1g-dev yasm pkg-config libgmp-dev libpcap-dev libbz2-dev nvidia-opencl-dev >> server-setup.log && echo 'Additional Package Installation: [COMPLETE]'

echo 'Adding user: [ean] to group: [docker]'
usermod -aG docker ean && echo 'User added to [docker group]' >> server-setup.log

echo 'Configuring NFS connection to NAS'
su -c "echo '192.168.1.21:/remote  /mnt/NAS  nfs  defaults  0  0' >> /etc/fstab" && echo 'NAS entry added to /etc/fstab' >> server-setup.log
mkdir /mnt/NAS && echo 'Created /mnt/NAS directory' >> server-setup.log

echo 'Adding /etc/hosts entries:'
su -c "echo '' >> /etc/hosts" && su -c "echo '# GNS3 Servers:' >> /etc/hosts" && su -c "echo '192.168.1.31 server-1' >> /etc/hosts" && su -c "echo '192.168.1.32 server-2' >> /etc/hosts" && su -c "echo '192.168.1.32 server-3' >> /etc/hosts" && su -c "echo '192.168.1.34 server-4' >> /etc/hosts" && echo 'Added GNS3 Servers to /etc/hosts' >> server-setup.log

reboot