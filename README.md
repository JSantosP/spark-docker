## Pre-requisites ##

For solving some spark name resolution problems when using Windows or OSX (a VM is needed), you need to add to your ```/etc/hosts``` file the following line:

```
<YOUR-DOCKER-VM> spark-cluster
```

where ```<YOUR-DOCKER-VM>``` is usually ```192.168.99.100```

## Launching ##

Just run:

```
docker run -d -P -p 8080:8080 -p 7077:7077 -p 8888:8888 -p 8081:8081 -p 4040:4040 -p 7001:7001 -p 7002:7002 -p 7003:7003 -p 7004:7004 -p 7005:7005 -p 7006:7006 -h spark-cluster --name spark jsantosp/spark
```