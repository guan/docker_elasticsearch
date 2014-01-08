FROM ubuntu

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Tool Install

RUN apt-get install -y git wget vim

# Java install

RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7u25-b15/server-jre-7u25-linux-x64.tar.gz" -O "server-jre-7u25-linux-x64.tar.gz"
RUN mkdir /usr/java
RUN tar xzf server-jre-7u25-linux-x64.tar.gz -C /usr/java/

# Elastic Search install
ENV JAVA_HOME /usr/java/jdk1.7.0_25
RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.deb
RUN dpkg -i elasticsearch-0.90.7.deb
RUN "export JAVA_HOME=/usr/java/jdk1.7.0_25" | tee -a /etc/default/elasticsearch
RUN service elasticsearch stop

# Elastic Plugin Install

RUN JAVA_HOME=/usr/java/jdk1.7.0_25 /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/1.6.0
RUN AVA_HOME=/usr/java/jdk1.7.0_25 /usr/share/elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ


# Elastic Search Config

ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

# Docker Option

EXPOSE 9200

CMD ["/usr/share/elasticsearch/bin/elasticsearch","-f"]