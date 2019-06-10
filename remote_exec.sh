#!/usr/bin/bash
if [ $# -ne 1 ]; then
	echo -e "Userage: ./install-n2n.sh machine_num."
	exit -1
fi
localip=(
192.168.1.108
192.168.1.67
192.168.1.200
192.168.1.98
192.168.1.107
192.168.1.25
192.168.1.122
192.168.1.110
192.168.1.247
192.168.1.15
192.168.1.250
192.168.1.190
192.168.1.195
192.168.1.160
192.168.1.57
192.168.1.44
192.168.1.85
192.168.1.100
)

NUM=$1
IP=${localip[$NUM-1]}
#echo "exec yum install -y git && cd /root/ && rm -rf /root/myshell &&git clone https://github.com/lituren99/myshell.git && sh /root/myshell/remote_install-n2n.sh  $NUM on root@$IP"

#ssh root@$IP "yum install -y git && cd /root/ && rm -rf /root/myshell &&git clone https://github.com/lituren99/myshell.git && sh /root/myshell/remote_install-n2n.sh  $NUM"

set timeout 30
expect<<-END
   spawn ssh root@$IP "yum install -y git && cd /root/ && rm -rf /root/myshell && git clone https://github.com/lituren99/myshell.git && sh /root/myshell/remote_install-n2n.sh  $NUM" 
   expect "password:"
   send "llkjA1b2c3d4\r"
expect "min/avg/max/mdev ="
exit
END
ping 192.168.100.$NUM -c 5





