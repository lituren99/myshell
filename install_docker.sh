#!/usr/bin/bash

vpnipaddr=(
192.168.100.36
192.168.100.37
192.168.100.38
)
localip=(
172.31.0.17
172.31.0.15
172.31.0.49
)



USR="root"
PWD="llkjA1b2c3d4"
CMD="/root/myshell/get-docker.sh"

#for ip in ${localip[@]}
#do
#    /root/myshell/expect_cmd.exp $PWD ssh $USR@$ip ifconfig edge0 mtu 1300 
#done

for IP in ${vpnipaddr[@]}
do
    /root/myshell/expect_exescpt.exp $IP $USR $PWD $CMD 
done


