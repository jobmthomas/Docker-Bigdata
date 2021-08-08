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

#**************************************** INSTALLING hadoop and configure ******************************
RUN mkdir hadoop
RUN wget -P /hadoop/ https://archive.apache.org/dist/hadoop/core/hadoop-2.7.7/hadoop-2.7.7.tar.gz
RUN tar -xzvf /hadoop/hadoop-2.7.7.tar.gz -C /hadoop
ADD ./config/core-site.xml ./hadoop/hadoop-2.7.7/etc/hadoop
ADD ./config/hdfs-site.xml ./hadoop/hadoop-2.7.7/etc/hadoop
ADD ./config/hadoop-env.sh ./hadoop/hadoop-2.7.7/etc/hadoop
ADD ./config/mapred-site.xml ./hadoop/hadoop-2.7.7/etc/hadoop
ADD ./config/yarn-site.xml ./hadoop/hadoop-2.7.7/etc/hadoop
ENV HADOOP_HOME /hadoop/hadoop-2.7.7
ENV PATH $PATH:$HADOOP_HOME/bin
RUN echo "export HADOOP_HOME=/hadoop/hadoop-2.7.7" >>~/.bash_profile
RUN echo "export PATH=$PATH:$HADOOP_HOME/bin" >>~/.bash_profile
RUN $HADOOP_HOME/bin/hdfs namenode -format

#**************************************** INSTALLING sqoop and configure ******************************
RUN mkdir sqoop
RUN wget -P /sqoop/ http://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
RUN tar -xzvf /sqoop/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz -C /sqoop
ADD ./config/mssql-jdbc-7.0.0.jre8.jar ./sqoop/sqoop-1.4.7.bin__hadoop-2.6.0/lib
ENV SQOOP_HOME /sqoop/sqoop-1.4.7.bin__hadoop-2.6.0
ENV PATH $PATH:$SQOOP_HOME/bin
RUN echo "export SQOOP_HOME=/sqoop/sqoop-1.4.7.bin__hadoop-2.6.0" >>~/.bash_profile
RUN echo "export PATH=$PATH:$SQOOP_HOME/bin" >>~/.bash_profile

#**************************************** INSTALLING hive and configure ******************************
RUN mkdir hive
RUN wget -P /hive/ https://archive.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz
RUN tar -xzvf /hive/apache-hive-1.2.1-bin.tar.gz -C /hive
ADD ./config/hive-site.xml ./hive/apache-hive-1.2.1-bin/conf
ADD ./config/mssql-jdbc-7.0.0.jre8.jar ./hive/apache-hive-1.2.1-bin/lib
ADD ./config/hive-schema-1.2.0.mssql.sql ./hive/apache-hive-1.2.1-bin/scripts/metastore/upgrade/mssql/
ENV HIVE_HOME /hive/apache-hive-1.2.1-bin
ENV PATH $PATH:$HIVE_HOME/bin
RUN echo "export HIVE_HOME=/hive/apache-hive-1.2.1-bin" >>~/.bash_profile
RUN echo "export PATH=$PATH:$HIVE_HOME/bin" >>~/.bash_profile

#********************************************* Moving ~/.bash_profile to /etc/profile.d/ to get env variables to all users ****************
RUN cp ~/.bash_profile /etc/profile.d/bash_profile.sh
#**************************************** load script to start/stop the ecosystem ******************************
ADD ./config/start-hadoop-ecosystem.sh .
ADD ./config/stop-hadoop-ecosystem.sh .
EXPOSE 22
EXPOSE 9000
#EXPOSE 50070
EXPOSE 8088
EXPOSE 9870
EXPOSE 10000
EXPOSE 9999
EXPOSE 9083
EXPOSE 10500
