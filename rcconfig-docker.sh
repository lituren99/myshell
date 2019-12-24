#!/usr/bin/bash
vpnipaddr=(
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
PORT="8480"

for(( i=0;i<${#vpnipaddr[@]};i++)) do
   VPNIP=${vpnipaddr[$i]}
   /root/myshell/expect_cmd.exp $PWD  scp -P $PORT /usr/lib/systemd/system/docker.service root@$VPNIP:/usr/lib/systemd/system/
   /root/myshell/expect_cmd.exp $PWD  ssh -p $PORT root@$VPNIP systemctl daemon-reload
   /root/myshell/expect_cmd.exp $PWD  ssh -p $PORT root@$VPNIP systemctl restart docker
done


