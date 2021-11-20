#!/bin/bash

echo "在系统增加一些常用的简短命令符..."

yes | cp -f ./cfg/cmd.alias /etc/profile.d/k8s-alias.sh
chmod +x /etc/profile.d/k8s-alias.sh
/etc/profile.d/k8s-alias.sh

cat /etc/profile.d/k8s-alias.sh
echo "---------------------------------"
echo "已添加完毕..重新登入shell后尝试使用短命令..."
