#!/bin/bash

echo "请确定这是安装k8s node!!!"

./01_pre_check_and_configure.sh

./02_install_docker.sh

./03_install_kubernetes.sh

./04_pull_docker_images.sh

echo "请使用kubeadm join命令增加节点到k8s集群..."

