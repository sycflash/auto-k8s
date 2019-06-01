#!/bin/bash

# step 1: install docker
echo "# step 1: install docker"
yum -y install docker

# step 2: install etcd
echo "# step 2: install etcd"
yum install etcd -y

sed -i 's!ETCD_NAME.*$!ETCD_NAME=$(hostname)!' /etc/etcd/etcd.conf
sed -i 's!ETCD_LISTEN_CLIENT_URLS=.*$!ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379,http://0.0.0.0:4001"!'  /etc/etcd/etcd.conf
sed -i 's!ETCD_ADVERTISE_CLIENT_URLS=.*$!ETCD_ADVERTISE_CLIENT_URLS="http://0.0.0.0:2379,http://0.0.0.0:4001"!' /etc/etcd/etcd.conf

systemctl stop etcd
systemctl start etcd
systemctl enable etcd

# step 3:install kubernetes
echo "# step 3:install kubernetes"
k8s-master=10.0.2.15
yum -y  install kubernetes

sed -i 's!KUBE_API_ADDRESS=.*$!KUBE_API_ADDRESS="--insecure-bind-address=0.0.0.0"!' /etc/kubernetes/apiserver
sed -i 's!KUBE_API_PORT=.*$!KUBE_API_PORT="--port=8080"!' /etc/kubernetes/apiserver
sed -i 's!KUBE_ETCD_SERVERS=.*$!KUBE_ETCD_SERVERS="--etcd-servers=http://0.0.0.0:2379"!' /etc/kubernetes/apiserver
sed -i 's!KUBE_ADMISSION_CONTROL=.*$!KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota"!' /etc/kubernetes/apiserver

sed -i 's!KUBE_MASTER=.*$!KUBE_MASTER="--master=http://${k8s-master}:8080"!' /etc/kubernetes/config

./k8s-master-control.sh enable
./k8s-master-control.sh stop
./k8s-master-control.sh start

# step 4:setting iptables
echo "# step 4:setting iptables"
iptables-restore ./iptables.master
