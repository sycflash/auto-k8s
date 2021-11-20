#!/bin/bash

wget https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo -O /etc/yum.repos.d/docker-ce.repo
yum list docker-ce
yum -y install docker-ce

yes | cp -f ./cfg/daemon.json /etc/docker/daemon.json

systemctl start docker
systemctl enable docker

