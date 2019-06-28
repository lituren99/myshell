#!/usr/bin/bash
if [ $# -ne 1 ]; then
	echo -e "Userage:  init_swarm.sh manager_machine_ip."
	exit -1
fi

vpnipaddr=(
192.168.100.241
192.168.100.242
192.168.100.243
192.168.100.21
192.168.100.22
192.168.100.23
192.168.100.24
192.168.100.25
192.168.100.26
192.168.100.27
192.168.100.28
192.168.100.29
192.168.100.30
192.168.100.31
192.168.100.32
192.168.100.33
192.168.100.34
192.168.100.35
)

USR="root"
PWD="llkjA1b2c3d4"

managerip=$1
./expect_cmd.exp $PWD ssh $USR@$managerip docker swarm init --advertise-addr $managerip
joinswarmcmd=`./expect_cmd.exp $PWD ssh $USR@$managerip docker swarm join-token worker | awk '{if($1=="docker") print $0}'`

for workerip in ${vpnipaddr[@]} do
   #echo $ip   
   if [$workerip -ne $MGRIP]; then 
      ./expect_cmd.exp $PWD ssh $USR@$workerip joinswarmcmd
   fi
done
