#!/bin/bash

#initialize metastore schema for hive and start
$HIVE_HOME/bin/schematool -dbType mssql -initSchema
hive --service metastore &
echo $! > hive-metsatore-pid.txt
hive --service hiveserver2 &
echo $! > hive-server2-pid.txt
