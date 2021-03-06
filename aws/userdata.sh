#!/bin/bash

#sudo su -
apt-get update
apt-get --yes install mdadm xfsprogs jq git python-pip python-protobuf cmake libgeoip-dev zlib1g-dev mercurial
pip install awscli boto
umount /mnt
yes | mdadm --create /dev/md0 --level=0 -c64 --raid-devices=2 /dev/xvdb /dev/xvdc
echo 'DEVICE /dev/xvdb /dev/xvdc' >> /etc/mdadm/mdadm.conf
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
mkfs.xfs /dev/md0
mount /dev/md0 /mnt
mkdir -p /mnt/work
chown -R ubuntu:ubuntu /mnt/work

cd /mnt/work
wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.4.2.linux-amd64.tar.gz

wget http://people.mozilla.org/~mreid/heka-data-pipeline-linux-amd64.tar.gz
tar xzvf heka-data-pipeline-linux-amd64.tar.gz
