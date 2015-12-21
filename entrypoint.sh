#!/bin/bash

echo ${MYID:-1} > /etc/zookeeper/conf/myid

if [ ! -z "$SERVERS" ]; then
 IFS=',' read -r -a array <<< "$SERVERS"
 j=1;
 for server in ${array[@]}; do 
    echo server.$j=$server:2888:3888  >> /etc/zookeeper/conf/zoo.cfg
    ((j=j+1))
 done 
fi

exec "$@"
