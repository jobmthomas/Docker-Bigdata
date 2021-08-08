#!/bin/bash

# Start SSH server
service ssh start

# Start dfs  
#HADOOP_HOME/sbin/start-dfs.sh

# Start yarn  
#HADOOP_HOME/sbin/start-yarn.sh

#initialize metastore schema for hive and start
$HIVE_HOME/bin/schematool -dbType mssql -initSchema
#hive --service metastore &
#echo $! > hive-metsatore-pid.txt
#hive --service hiveserver2 &
#echo $! > hive-server2-pid.txt

# To keep container running
tail -f /dev/null 
