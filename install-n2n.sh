
VPNIP=$1
VPNMAC=$2
SUPERNODE1=$3
SUPERNODE2=$4

ifconfig

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
edge -d edge0 -k llkj7788 -c llkj_virtual_network -l $SUPERNODE1 $SUPERNODE2 -s 255.255.255.0 -r -a $VPNIP -m $VPNMAC
ifconfig edge
ping 192.168.100.251 -c 5






