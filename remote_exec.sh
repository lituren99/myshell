#!/usr/bin/bash
if [ $# -ne 1 ]; then
	echo -e "Userage: ./install-n2n.sh machine_num."
	exit -1
fi
localip=(
172.31.0.45
172.31.0.37
172.31.0.18
172.31.0.67
172.31.0.28
172.31.0.40
172.31.0.44
172.31.0.42
172.31.0.22
172.31.0.39
172.31.0.27
172.31.0.32
172.31.0.29
172.31.0.52
172.31.0.30
172.31.0.38
172.31.0.41
172.31.0.26
)
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
NUM=$1
IP=${localip[$NUM-1]}
VPNIP=${vpnipaddr[$NUM-1]}
PWD="llkjA1b2c3d4"
CMD="/root/myshell/remote_install-n2n.sh"
#echo "/root/myshell/execute.expect $IP $NUM $PWD $CMD"
#ssh root@$IP "bash -s" <$CMD $NUM 
#/root/myshell/execute.expect $IP $NUM $PWD $CMD
./exescpt.exp $IP $PWD $CMD $NUM
ping $VPNIP -c 5

