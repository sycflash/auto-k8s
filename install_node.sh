#!/bin/bash

echo "请确定这是安装k8s node!!!"

./01_pre_check_and_configure.sh

./02_install_docker.sh

./03_install_kubernetes.sh

./04_pull_docker_images.sh

echo "请使用以上命令增加节点到k8s集群..."
echo
echo "kubeadm join 172.17.0.10:6443 --token sk70o8.wiv6hx1o2jjfb4ee \
        --discovery-token-ca-cert-hash sha256:e6e7d8875598a07a974791afdfaa85ca7696b2532c692e768843073ad239a4b8"

