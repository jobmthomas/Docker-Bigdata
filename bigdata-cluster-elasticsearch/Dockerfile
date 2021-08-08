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
ADD ./config/start-elasticsearch.sh .
ADD ./config/stop-elasticsearch.sh .
EXPOSE 9200
EXPOSE 9300