#!/bin/bash

# Stop dfs  
$HADOOP_HOME/sbin/stop-dfs.sh

# Stop yarn  
$HADOOP_HOME/sbin/stop-yarn.sh
pkill -f "ResourceManager"

#stop hive
pid=$(head -n 1 hive-metsatore-pid.txt)
kill -9 $pid

pid=$(head -n 1 hive-server2-pid.txt)
kill -9 $pid

#stop nifi
sudo service nifi stop

# Stop Kafka server
PIDS=$(ps ax | grep -i 'kafka\.Kafka' | grep java | grep -v grep | awk '{print $1}')

if [ -z "$PIDS" ]; then
  echo "No kafka server to stop"
else
  kill -9 $PIDS
fi

# Stop Kafka Zookeeper
PIDS=$(ps ax | grep java | grep -i QuorumPeerMain | grep -v grep | awk '{print $1}')

if [ -z "$PIDS" ]; then
  echo "No zookeeper server to stop"
else
  kill -9 $PIDS
fi


#stop elastic search
pid=$(head -n 1 elsaticsearch-pid.txt)
kill -9 $pid


