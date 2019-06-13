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
USR="root"
PWD="llkjA1b2c3d4"
for NUM in {1..18}
do
IP=${localip[$NUM-1]}
./expect_cmd.exp $PWD ssh $USR@$IP ifconfig edge0 mtu $1
done
