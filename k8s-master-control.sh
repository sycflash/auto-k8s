#!/bin/bash
services=(kube-apiserver.service kube-controller-manager.service kube-scheduler.service)
action=$1
for service in ${services[@]}
do
        systemctl $1 $service
done
