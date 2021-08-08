#!/bin/bash

# Start nifi
sudo service nifi start

# To keep container running
tail -f /dev/null 
