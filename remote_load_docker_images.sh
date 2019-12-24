#!/usr/bin/bash

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
CMD="/root/myshell/loadimages.sh"

for(( i=0;i<${#vpnipaddr[@]};i++)) do
   VPNIP=${vpnipaddr[$i]}
   /root/myshell/expect_exescpt.exp $VPNIP $USR $PWD $CMD 
done


