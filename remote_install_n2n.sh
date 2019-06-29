#!/usr/bin/bash
localip=(
172.31.0.17
172.31.0.15
172.31.0.49
)
vpnipaddr=(
192.168.100.36
192.168.100.37
192.168.100.38
)

vpnmac=(
FB:11:A2:A3:1C:1B
06:D6:1C:C7:34:1F
CF:9E:DB:60:E0:25
)

SUPERNODE1=119.3.252.42:50001
SUPERNODE2=117.73.11.109:50001

USR="root"
PWD="llkjA1b2c3d4"
CMD="/root/myshell/install-n2n.sh"

for(( i=0;i<${#localip[@]};i++)) do
   IP=${localip[$i]}
   VPNIP=${vpnipaddr[$i]}
   VPNMAC=${vpnmac[$i]}
   /root/myshell/expect_exescpt.exp $IP $USR $PWD $CMD $VPNIP $VPNMAC $SUPERNODE1 $SUPERNODE2
   ping $VPNIP -c 5   
done


