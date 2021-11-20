#!/bin/bash

log_path=/tmp/init_master.log
master_ip4=$(grep master ./cfg/hosts.k8s | awk '{print $1}')

kubeadm init \
 --kubernetes-version=v1.22.4 \
 --pod-network-cidr=10.244.0.0/16 \
 --service-cidr=10.96.0.0/12 \
 --apiserver-advertise-address=${master_ip4} \
 | tee ${log_path}

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo
echo "初始化master节点完毕,你可以在${log_path}文件中查看安装日志..."
