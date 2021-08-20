#!/bin/bash
#pull images

ver=v1.21.0
registry=registry.cn-hangzhou.aliyuncs.com/google_containers
images=`kubeadm config images list --kubernetes-version=$ver |awk -F '/' '{print $2}'`

for image in $images
do
if [ $image != coredns ];then
    docker pull ${registry}/$image
    if [ $? -eq 0 ];then
        docker tag ${registry}/$image k8s.gcr.io/$image
        docker rmi ${registry}/$image
    else
        echo "ERROR: 下载镜像报错，$image"
    fi
else
    docker pull coredns/coredns:1.8.0
    docker tag coredns/coredns:1.8.0  k8s.gcr.io/coredns/coredns:v1.8.0
    docker rmi coredns/coredns:1.8.0
fi
done
