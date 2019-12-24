#!/usr/bin/bash
if [ $# -ne 1 ]; then
	echo -e "Userage:  init_swarm.sh manager_machine_ip."
	exit -1
fi

vpnipaddr=(
192.168.99.100
192.168.99.101
192.168.99.102
192.168.99.103
192.168.99.104
192.168.99.105
192.168.99.106
192.168.99.107
192.168.99.108
)

USR="root"
PWD="REDHATmsd123"

managerip=$1
./expect_cmd.exp $PWD ssh -p 8480 $USR@$managerip  systemctl start docker
./expect_cmd.exp $PWD ssh -p 8480 $USR@$managerip docker swarm leave -f
./expect_cmd.exp $PWD ssh -p 8480 $USR@$managerip docker swarm init --advertise-addr $managerip
joinswarmcmd=`./expect_cmd.exp $PWD ssh -p 8480 $USR@$managerip docker swarm join-token worker | awk '{if($1=="docker") print $0}'`
#echo "test : $joinswarmcmd"
for workerip in ${vpnipaddr[@]} 
do
#   echo "workip:$workerip / mgrip:$managerip"
   if [ "$managerip" != "$workerip" ];then 
     ./expect_cmd.exp $PWD ssh -p 8480 $USR@$workerip systemctl start docker
     ./expect_cmd.exp $PWD ssh -p 8480 $USR@$workerip docker swarm leave -f 
     ./expect_cmd.exp $PWD ssh -p 8480 $USR@$workerip "\"${joinswarmcmd}\""
   fi
done
./expect_cmd.exp $PWD ssh -p 8480 $USR@$managerip docker network create -d overlay --attachable fabric_default --opt com.docker.network.driver.mtu=1299

