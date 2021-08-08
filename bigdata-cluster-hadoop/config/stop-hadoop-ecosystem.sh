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



