#!/bin/bash

yum -y  install kubernetes
k8s_master=10.0.2.15

sed -i 's!KUBE_MASTER=.*$!KUBE_MASTER="--master=http://'${k8s_master}':8080"!' /etc/kubernetes/config
sed -i 's!KUBELET_ADDRESS=.*$!KUBELET_ADDRESS="--address=0.0.0.0"!' /etc/kubernetes/kubelet
sed -i 's!KUBELET_HOSTNAME=.*$!KUBELET_HOSTNAME="--hostname-override='$(hostname)'"!' /etc/kubernetes/kubelet
sed -i 's!KUBELET_API_SERVER=.*$!KUBELET_API_SERVER="--api-servers=http://'${k8s_master}':8080"!' /etc/kubernetes/kubelet

systemctl enable kubelet.service
systemctl stop kubelet.service
systemctl start kubelet.service

systemctl enable kube-proxy.service
systemctl stop kube-proxy.service
systemctl start kube-proxy.service

