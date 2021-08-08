#!/bin/bash

#stop hive
pid=$(head -n 1 hive-metsatore-pid.txt)
kill -9 $pid

pid=$(head -n 1 hive-server2-pid.txt)
kill -9 $pid