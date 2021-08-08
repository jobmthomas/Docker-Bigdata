#!/bin/bash

# Stop dfs  
$HADOOP_HOME/sbin/stop-dfs.sh

# Stop yarn  
$HADOOP_HOME/sbin/stop-yarn.sh
pkill -f "ResourceManager"
