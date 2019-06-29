#!/usr/bin/bash
if [ $# -ne 1 ]; then
	echo -e "Userage:  init_swarm.sh manager_machine_ip."
	exit -1
fi

vpnipaddr=(
192.168.100.36
192.168.100.37
192.168.100.38
)

USR="root"
PWD="llkjA1b2c3d4"

managerip=$1
./expect_cmd.exp $PWD ssh $USR@$managerip  systemctl start docker
./expect_cmd.exp $PWD ssh $USR@$managerip docker swarm leave -f
./expect_cmd.exp $PWD ssh $USR@$managerip docker swarm init --advertise-addr $managerip
joinswarmcmd=`./expect_cmd.exp $PWD ssh $USR@$managerip docker swarm join-token worker | awk '{if($1=="docker") print $0}'`
#echo "test : $joinswarmcmd"
for workerip in ${vpnipaddr[@]} 
do
#   echo "workip:$workerip / mgrip:$managerip"
   if [ "$managerip" != "$workerip" ];then 
     ./expect_cmd.exp $PWD ssh $USR@$workerip systemctl start docker
     ./expect_cmd.exp $PWD ssh $USR@$workerip docker swarm leave -f 
     ./expect_cmd.exp $PWD ssh $USR@$workerip "\"${joinswarmcmd}\""
   fi
done
