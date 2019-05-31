#!/bin/bash

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
