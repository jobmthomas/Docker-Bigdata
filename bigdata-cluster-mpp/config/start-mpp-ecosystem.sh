#!/bin/bash

# Start SSH server
service ssh start

# Start Kafka Zookeeper
#$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties &

# Start Kafka server
#$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties &

# To keep container running
tail -f /dev/null 
