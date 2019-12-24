#!/bin/bash
netfile=$1
if [ X$1 = X ] 
then
    netfile="./net_kafka.yml"
fi
PWD='llkjA1b2c3d4'
rootdir="/root/dockerimages/onekey"
PROJECTPATH=`grep -E  "PROJECT_PATH:" $netfile | awk -F':' '{print $2}' |sed 's/^[ \t]*//g'`
PORT=22

#分发 peer 节点证书
str=`grep -E  "peer" $netfile | grep -v "couchdb"  | awk -F':' '{for( i=1;i<NF; i+=2 ) print $i,$(i+1)}'`
OLD_IFS="$IFS" #保存旧的分隔符
IFS=" "
array=($str)
IFS="$OLD_IFS" # 将IFS恢复成原来的
i=0
while [ $i -lt ${#array[*]} ]
do
    peername=`echo ${array[i]} |sed 's/^[ \t]*//g'`
    orgname=`echo $peername | sed 's/peer*..//g' |sed 's/^[ \t]*//g'`
    domain=`echo $orgname | sed 's/org*..//g' |sed 's/^[ \t]*//g'`
    ip=`echo ${array[i+1]} |sed 's/^[ \t]*//g'`
    #echo "$peername-->$orgname--->$domain----->$ip"
    src="$rootdir/crypto-config/peerOrganizations/$orgname/peers/$peername"
    dst="/root/fabric"
    ./expect_cmd.sh $PWD ssh -p $PORT root@$ip rm -rf $dst/crypto-config
    ./expect_cmd.sh $PWD ssh -p $PORT root@$ip mkdir -p $dst/crypto-config/peerOrganizations/$orgname/peers
    ./expect_cmd.sh $PWD scp -r -P $PORT $src  root@$ip:$dst/crypto-config/peerOrganizations/$orgname/peers
    #echo "/root/myshell/expect_cmd.exp $password scp -r -P 8480 $src root@$ip:$dst/"
    i=$(( $i + 2 ))
done

#分发 order 节点证书
str=`grep -E  "orderer" $netfile | grep -v "couchdb"  | awk -F':' '{for( i=1;i<NF; i+=2 ) print $i,$(i+1)}'`
OLD_IFS="$IFS" #保存旧的分隔符
IFS=" "
array=($str)
IFS="$OLD_IFS" # 将IFS恢复成原来的
i=0
while [ $i -lt ${#array[*]} ]
do
    ordername=`echo ${array[i]} |sed 's/^[ \t]*//g'`
    domain=`echo $ordername | sed 's/orderer*..//g' |sed 's/^[ \t]*//g'`
    ip=`echo ${array[i+1]} |sed 's/^[ \t]*//g'`
    #echo "$svrname-->$svrip"
    src="$rootdir/crypto-config/ordererOrganizations/$domain/orderers/$ordername"
    dst="/root/fabric"
    #echo "$PWD ssh -p $PORT root@$ip rm -rf $dst/crypto-config"
    ./expect_cmd.sh $PWD ssh -p $PORT root@$ip rm -rf $dst/crypto-config
    ./expect_cmd.sh $PWD ssh -p $PORT root@$ip mkdir -p $dst/crypto-config/ordererOrganizations/$domain/orderers
    ./expect_cmd.sh $PWD scp -r -P $PORT $src  root@$ip:$dst/crypto-config/ordererOrganizations/$domain/orderers
    #echo "/root/myshell/expect_cmd.exp $password scp -r -P 8480 $src root@$ip:$dst/"
    i=$(( $i + 2 ))
done

#分发创始块和通道
str=`grep -E  "cli|orderer" $netfile | grep -v "couchdb"  | awk -F':' '{for( i=1;i<NF; i+=2 ) print $i,$(i+1)}'`
OLD_IFS="$IFS" #保存旧的分隔符
IFS=" "
array=($str)
IFS="$OLD_IFS" # 将IFS恢复成原来的
i=0
while [ $i -lt ${#array[*]} ]
do
    ordername=`echo ${array[i]} |sed 's/^[ \t]*//g'`
    ip=`echo ${array[i+1]} |sed 's/^[ \t]*//g'`
    #echo "$svrname-->$svrip"
    src="$rootdir/channel-artifacts"
    dst="/root/fabric"
    ./expect_cmd.sh $PWD ssh -p $PORT root@$ip rm -rf $dst/channel-artifacts
    ./expect_cmd.sh $PWD ssh -p $PORT root@$ip mkdir -p $dst
    ./expect_cmd.sh $PWD scp -r -P $PORT $src  root@$ip:$dst
    #echo "/root/myshell/expect_cmd.exp $password scp -r -P 8480 $src root@$ip:$dst/"
    i=$(( $i + 2 ))
done
