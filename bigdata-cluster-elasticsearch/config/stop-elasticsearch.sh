#!/bin/bash

#stop elastic search
pid=$(head -n 1 elsaticsearch-pid.txt)
kill -9 $pid
