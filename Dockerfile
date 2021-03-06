FROM ubuntu:14.04

MAINTAINER Wyred <javier.santos@wyred.biz>

ENV HOSTNAME spark-cluster
ENV HADOOP_VERSION 2.6
ENV SPARK_VERSION 1.6.1

COPY start.sh /usr/local
RUN chmod 755 /usr/local/start.sh

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer oracle-java8-set-default

RUN apt-get -y install curl
RUN apt-get -y install ssh

#RUN curl -s http://ftp.cixug.es/apache/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
#RUN cd /usr/local && ln -s spark-1.6.1-bin-hadoop2.6 spark

COPY spark-${SPARK_VERSION}-bin-spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz /usr/local/
RUN cd /usr/local && tar -xvf /usr/local/spark-${SPARK_VERSION}-bin-spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

RUN cd /usr/local && ln -s /usr/local/spark-${SPARK_VERSION}-bin-spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark
ENV SPARK_HOME /usr/local/spark

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_PORT 8888
ENV SPARK_WORKER_WEBUI_PORT 8081

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006 

ENV SPARK_MASTER_IP spark-cluster

CMD ["/usr/local/start.sh"]
