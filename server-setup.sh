#!/usr/bin/env bash

echo 'Adding GNS3 PPA...'
apt-add-repository ppa:gns3/ppa -y > server-setup.log && echo 'GNS3 PPA: [COMPLETE]'

echo 'Installing required Packages'
echo 'Installing required Packages' >> server-setup.log
apt install -y nfs-common python3-pip docker.io htop nvidia-headless-460-server htop build-essential git libssl-dev zlib1g-dev yasm pkg-config libgmp-dev libpcap-dev libbz2-dev nvidia-opencl-dev >> server-setup.log && echo 'Additional Package Installation: [COMPLETE]'
echo 'Installing required Packages: [COMPLETE]' >> server-setup.log

echo 'Installing GNS3-Server (Interactively):' >> server-setup.log
apt install -y gns3-server && echo 'Install GNS3-Server (Interactively): [COMPLETE]' >> server-setup.log

echo 'Adding user: [ean] to group: [docker]'
usermod -aG docker ean && echo 'User added to [docker group]' >> server-setup.log

echo 'Configuring NFS connection to NAS'
su -c "echo '192.168.1.21:/remote  /mnt/NAS  nfs  defaults  0  0' >> /etc/fstab" && echo 'NAS entry added to /etc/fstab' >> server-setup.log
mkdir /mnt/NAS && echo 'Created /mnt/NAS directory' >> server-setup.log

echo 'Setting up GNS3 Service'
echo 'Setting up GNS3 Service' >> server-setup.log
wget https://raw.githubusercontent.com/eantowne/Personal-Common-Scripts/master/gns3.service.systemd
cp gns3.service.systemd /lib/systemd/system/gns3.service
chown root /lib/systemd/system/gns3.service
systemctl start gns3
systemctl enable gns3 >> server-setup.log
echo 'GNS3 Service Setup: [COMPLETE]' >> server-setup.log

echo 'REBOOTING NOW!' echo 'REBOOTING' >> server-setup.log
reboot
