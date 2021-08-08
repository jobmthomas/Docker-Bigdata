FROM ubuntu:16.04
#**************************************** INSTALLLING java ******************************
RUN apt-get -y update
RUN apt-get -y upgrade 
RUN apt-get -y install openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >>~/.bash_profile
RUN echo "export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin" >>~/.bash_profile

#**************************************** INSTALLING rsync vim sudo openssh-server ssh ******************************
RUN apt-get -y update
RUN apt-get -y upgrade 
RUN apt-get -y install rsync
RUN apt-get -y install vim sudo
RUN apt-get -y install openssh-server
RUN apt-get -y install ssh
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys
ADD ./config/ssh_config /etc/ssh/
EXPOSE 22
RUN echo "root:root" | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#**************************************** INSTALLING spark and configure ******************************
RUN apt-get -y install scala
RUN mkdir spark
RUN wget -P /spark/ https://mirrors.estointernet.in/apache/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz
RUN tar -xzvf /spark/spark-3.0.3-bin-hadoop2.7.tgz -C /spark
ADD ./config/hive-site.xml ./spark/spark-3.0.3-bin-hadoop2.7/conf
ADD ./config/core-site.xml ./spark/spark-3.0.3-bin-hadoop2.7/conf
ADD ./config/hdfs-site.xml ./spark/spark-3.0.3-bin-hadoop2.7/conf
ADD ./config/mapred-site.xml ./spark/spark-3.0.3-bin-hadoop2.7/conf
ENV SPARK_HOME /spark/spark-3.0.3-bin-hadoop2.7
ENV PATH $PATH:$SPARK_HOME/bin
RUN echo "export SPARK_HOME=/spark/spark-3.0.3-bin-hadoop2.7" >>~/.bash_profile
RUN echo "export PATH=$PATH:$SPARK_HOME/bin" >>~/.bash_profile
RUN apt-get -y install python2.7 python-pip

#**************************************** INSTALLING Kafka and configure ******************************
RUN mkdir kafka
RUN wget -P /kafka https://archive.apache.org/dist/kafka/2.2.2/kafka_2.11-2.2.2.tgz
RUN tar -xzvf /kafka/kafka_2.11-2.2.2.tgz -C /kafka
ENV KAFKA_HOME /kafka/kafka_2.11-2.2.2
ENV PATH $PATH:$KAFKA_HOME/bin
RUN echo "export KAFKA_HOME=/kafka/kafka_2.11-2.2.2" >>~/.bash_profile
RUN echo "export PATH=$PATH:$KAFKA_HOME/bin" >>~/.bash_profile

#**************************************** INSTALLING elastic search ******************************
RUN useradd -m  -s /bin/bash elastic
RUN echo "elastic:elastic" | chpasswd
RUN usermod -aG sudo elastic
RUN sudo -u elastic wget -P /home/elastic/ https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.1.1-linux-x86_64.tar.gz
RUN sudo -u elastic tar -xzvf /home/elastic/elasticsearch-7.1.1-linux-x86_64.tar.gz -C /home/elastic/
ENV ELASTIC_SEARCH_HOME /home/elastic/elasticsearch-7.1.1
ENV PATH $PATH:$ELASTIC_SEARCH_HOME/bin
RUN echo "export ELASTIC_SEARCH_HOME=/home/elastic/elasticsearch-7.1.1" >>~/.bash_profile
RUN echo "export PATH=$PATH:$ELASTIC_SEARCH_HOME/bin" >>~/.bash_profile

#********************************************* Moving ~/.bash_profile to /etc/profile.d/ to get env variables to all users ****************
RUN cp ~/.bash_profile /etc/profile.d/bash_profile.sh
#**************************************** load script to start/stop the ecosystem ******************************
ADD ./config/start-mpp-ecosystem.sh .
ADD ./config/stop-mpp-ecosystem.sh .

EXPOSE 9092
EXPOSE 2181

