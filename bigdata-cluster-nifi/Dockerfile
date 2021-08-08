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

#**************************************** INSTALLING NiFi and configure ******************************
RUN mkdir nifi
RUN wget -P /nifi https://mirrors.estointernet.in/apache/nifi/1.14.0/nifi-1.14.0-bin.tar.gz
RUN tar -xzvf /nifi/nifi-1.14.0-bin.tar.gz -C /nifi
RUN /nifi/nifi-1.14.0/bin/nifi.sh install

#********************************************* Moving ~/.bash_profile to /etc/profile.d/ to get env variables to all users ****************
RUN cp ~/.bash_profile /etc/profile.d/bash_profile.sh
#**************************************** load script to start/stop the ecosystem ******************************
ADD ./config/start-nifi.sh .
ADD ./config/stop-nifi.sh .
EXPOSE 8080
