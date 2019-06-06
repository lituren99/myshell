
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
vpnipaddr=(
192.168.100.1
192.168.100.2
192.168.100.3
192.168.100.4
192.168.100.5
192.168.100.6
192.168.100.7
192.168.100.8
192.168.100.9
192.168.100.10
192.168.100.11
192.168.100.12
192.168.100.13
192.168.100.14
192.168.100.15
192.168.100.251
192.168.100.252
192.168.100.253
)
vpnmacaddr=(
EE:71:71:7D:DA:90
7A:CB:B0:6B:FC:7C
8B:4B:B3:6A:EB:4A
8E:15:A7:6A:E9:F2
39:24:E7:E4:68:0C
83:04:90:A6:42:59
C1:8D:7F:E5:34:BA
B9:A2:6C:FD:83:28
18:55:75:43:BC:3B
68:4E:C3:9E:B0:C6
BA:D1:6C:F9:0C:99
78:80:86:66:08:1D
FC:5E:5E:A1:29:5D
08:FD:7F:E6:4D:9A
C4:12:FD:08:29:A2
B7:5A:07:32:6E:81
0D:9E:D9:89:5C:95
23:EB:B2:9F:A2:D6
)

VPNIP=${vpnipaddr[$1-1]}
VPNMAC=${vpnmacaddr[$1-1]}
#IP=${localip[$1-1]}

rm -rf /root/n2n
yum install git -y
git clone https://github.com/meyerd/n2n.git
yum install cmake -y
mkdir /root/n2n/n2n_v2/build/
cd /root/n2n/n2n_v2/build/
cmake ..
make
make install 
ps -ef| grep edge
kill -9 $(ps -e | grep edge | awk '{print $1}')
edge -d edge0 -k llkj7788 -c llkj_virtual_network -l 119.3.252.42:50001 117.73.9.148:50001 -s 255.255.255.0 -r -a $VPNIP -m $VPNMAC
ifconfig edge
ping 192.168.100.251 -c 5






