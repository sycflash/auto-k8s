#!/bin/bash

# 0.设置hosts
echo "======================"
echo "0.设置hosts..."
sed -i '/k8s/d' /etc/hosts
cat ./cfg/hosts.k8s >> /etc/hosts
cat /etc/hosts

# 1.禁用防火墙 
echo "======================"
echo "1.禁用防火墙..."
systemctl stop firewalld
systemctl disable firewalld
systemctl stop iptables
systemctl disable iptables

# 2.禁用SELinux
echo "======================"
echo "2.禁用SELinux..."
sed -i 's/SELINUX=.*\b$/SELINUX=disabled/' /etc/selinux/config
grep -E "SELINUX=.*\b$" /etc/selinux/config

# 3.禁用Swap分区
echo "======================"
echo "3.禁用Swap分区"
sed -i '/swap/d' /etc/fstab
mount -a

# 4.加载网桥过滤模块
echo "======================"
echo "4.加载网桥过滤模块..."
modprobe br_netfilter
lsmod |grep br_net 

# 5.配置IPVS功能
echo "======================"
echo "5.配置IPVS功能"
yum install ipset ipvsadmin -y 
cp ./cfg/ipvs.modules /etc/sysconfig/modules/
chmod +x /etc/sysconfig/modules/ipvs.modules
/bin/bash /etc/sysconfig/modules/ipvs.modules
lsmod |grep br_net
lsmod |grep -e ip_vs -e nf_conntrack

# 6.初始化配置完毕,重启服务器
echo "======================"
echo "初始化配置完毕,稍后将重启服务器!!!"
for i in 5 4 3 2 1
do
	echo "${i}秒后重启服务器!!!"
	sleep 1
done
reboot && exit
