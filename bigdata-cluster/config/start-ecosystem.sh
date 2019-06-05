#!/bin/bash

# Start SSH server
service ssh start

# Start dfs  
$HADOOP_HOME/sbin/start-dfs.sh

# Start yarn  
$HADOOP_HOME/sbin/start-yarn.sh

#initialize metastore schema for hive and start
$HIVE_HOME/bin/schematool -dbType mssql -initSchema
hive --service metastore &
echo $! > hive-metsatore-pid.txt
hive --service hiveserver2 &
echo $! > hive-server2-pid.txt

# Start nifi
sudo service nifi start

# Start Kafka Zookeeper
$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties &

# Start Kafka server
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties &

# Start elastic search ( Elastic search can't be started as root user )
sudo -u elastic $ELASTIC_SEARCH_HOME/bin/elasticsearch &
echo $! > elsaticsearch-pid.txt

# To keep container running
tail -f /dev/null 
