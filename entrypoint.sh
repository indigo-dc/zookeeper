#!/bin/bash

echo ${MYID:-1} > /etc/zookeeper/conf/myid

ZOO_CONF_FILE=/etc/zookeeper/conf/zoo.cfg

if [ ! -z "$SERVERS" ]; then
 # clean the conf - needed in case of restart
 sed -i '/^server\.[0-9]\+=.*/d' $ZOO_CONF_FILE

 IFS=',' read -r -a array <<< "$SERVERS"
 j=1;
 for server in ${array[@]}; do 
    echo server.$j=$server:2888:3888  >> $ZOO_CONF_FILE
    ((j=j+1))
 done 

fi

exec "$@"
