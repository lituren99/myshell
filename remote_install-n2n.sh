
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
vpnmacaddr=(
29:4C:18:B9:74:DC
49:9D:AE:3D:99:08
C1:F1:0E:A4:79:D3
30:76:7B:BC:94:25
83:37:58:D7:83:C9
F7:88:4A:43:9C:6E
4B:58:01:97:BE:13
05:13:84:57:27:45
59:0E:A6:15:08:C8
DE:F3:28:86:CA:6C
92:69:2F:04:A1:0D
B2:49:74:75:67:4D
D8:C6:90:B0:54:5E
7D:59:C6:67:71:44
BA:EF:58:E6:94:B6
81:76:E7:54:C0:29
56:44:39:07:29:9F
41:E0:46:C5:81:59
)

VPNIP=${vpnipaddr[$1-1]}
VPNMAC=${vpnmacaddr[$1-1]}
#IP=${localip[$1-1]}

rm -rf /root/n2n
yum install git -y
yum install gcc-c++ openssl-devel -y
cd /root/
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






