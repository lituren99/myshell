#!/usr/bin/bash
localip=(
#172.31.0.29
#172.31.0.22
#172.31.0.9
172.31.0.12
172.31.0.40
172.31.0.25
172.31.0.8
172.31.0.5
172.31.0.38
172.31.0.15
172.31.0.7
172.31.0.24
172.31.0.16
172.31.0.6
172.31.0.14
172.31.0.11
172.31.0.13
172.31.0.18
)

USR="root"
PWD="llkjA1b2c3d4"
CMD="/root/dockerimages/loadimages.sh"

for(( i=0;i<${#localip[@]};i++)) do
   IP=${localip[$i]}
   /root/myshell/expect_exescpt.exp $IP $USR $PWD $CMD 
done


