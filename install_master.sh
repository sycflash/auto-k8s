#!/bin/bash

echo "请确定这是安装k8s master!!!"

hostnamectl set-hostname k8s-master

./01_pre_check_and_configure.sh

./02_install_docker.sh

./03_install_kubernetes.sh

./04_pull_docker_images.sh

./05_init_master.sh

./06_install_cni_flannel.sh

./07_set_cmd_alias.sh
