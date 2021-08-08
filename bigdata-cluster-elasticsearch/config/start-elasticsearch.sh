#!/bin/bash

# Start elastic search ( Elastic search can't be started as root user )
sudo -u elastic $ELASTIC_SEARCH_HOME/bin/elasticsearch &
echo $! > elsaticsearch-pid.txt

# To keep container running
tail -f /dev/null 
