# Standalone Spark 1.6.1 for Hadoop 2.6 and built for Scala 2.11 (Java8) #

## From binaries ##

Just type:

```
docker pull jsantosp/spark:latest
```

## From sources ##

If you want to build it manually, you'll have to download Spark-1.6.1 with Hadoop 2.6 sources and build it manually against Scala 2.11 using Java8:

```
./make-distribution.sh --name spark-1.6.1-bin-hadoop2.6 --tgz -Phadoop-2.6 -Dscala-2.11 -DskipTests -Phive
```

Once done, place the TGZ generated file in the same folder as this Dockerfile. Then type:

```
docker build -t jsantosp/spark .
```

## Pre-requisites for making it run ##

For solving some spark name resolution problems when using Windows or OSX (a VM is needed), you need to add to your ```/etc/hosts``` file the following line:

```
<YOUR-DOCKER-VM> spark-cluster
```

where ```<YOUR-DOCKER-VM>``` is usually ```192.168.99.100```

## Launching ##

Run:

```
docker run -d -P -p 8080:8080 -p 7077:7077 -p 8888:8888 -p 8081:8081 -p 4040:4040 -p 7001:7001 -p 7002:7002 -p 7003:7003 -p 7004:7004 -p 7005:7005 -p 7006:7006 -h spark-cluster --name spark jsantosp/spark
```