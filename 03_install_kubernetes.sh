#!/bin/bash

echo "安装kubeadm,kubelet,kubectl" 
yes | cp -f ./cfg/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
yum list |grep kube
yum -y install kubeadm kubelet kubectl

# 修改kubelet启动配置,解决
cat /dev/null > /etc/sysconfig/kubelet
echo 'KUBELET_CGROUP_ARGS="--cgroup-driver=cgroupfs"' >> /etc/sysconfig/kubelet
echo 'KUBE_PROXY_MODE="ipvs"' >> /etc/sysconfig/kubelet
echo 'KUBELET_EXTRA_ARGS=' >> /etc/sysconfig/kubelet

echo "-------/etc/sysconfig/kubelet-------"
cat /etc/sysconfig/kubelet
echo "-------/etc/sysconfig/kubelet-------"

echo "重启kubelet"
systemctl enable kubelet
systemctl stop kubelet
systemctl start kubelet

systemctl status kubelet
