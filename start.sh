#! /bin/bash

/usr/local/spark/sbin/start-master.sh
/usr/local/spark/sbin/start-slave.sh -h spark-cluster spark://spark-cluster:7077

tail -f /dev/null