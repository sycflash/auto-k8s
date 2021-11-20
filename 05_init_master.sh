#!/bin/bash

master_ip4=$(grep master ./cfg/hosts.k8s | awk '{print $1}')

kubeadm init \
 --kubernetes-version=v1.22.4 \
 --pod-network-cidr=10.244.0.0/16 \
 --service-cidr=10.96.0.0/12 \
 --apiserver-advertise-address=${master_ip4} \
 | tee init_master.log


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
