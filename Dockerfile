FROM centos:7

RUN yum -y install krb5-server krb5-workstation
RUN yum -y install java-1.8.0-openjdk-headless
RUN yum -y install apache-commons-daemon-jsvc
RUN yum -y install which

RUN sed -i -e 's/#//' -e 's/default_ccache_name/# default_ccache_name/' /etc/krb5.conf

RUN useradd -u 1098 hdfs
RUN useradd -u 1066 spark


ADD spark-2.2.0-SNAPSHOT-bin-2.7.3.tgz /
RUN ln -s spark-2.2.0-SNAPSHOT-bin-2.7.3 spark
RUN chown -R -L spark /spark

ADD hadoop-2.7.3.tar.gz /
RUN ln -s hadoop-2.7.3 hadoop
RUN chown -R -L hdfs /hadoop


COPY core-site.xml /hadoop/etc/hadoop/
COPY hdfs-site.xml /hadoop/etc/hadoop/
COPY ssl-server.xml /hadoop/etc/hadoop/
COPY yarn-site.xml /hadoop/etc/hadoop/
COPY log4j.properties /spark/conf/

COPY start-namenode.sh /
COPY start-datanode.sh /
COPY populate-data.sh /
COPY start-kdc.sh /

COPY people.json /
COPY people.txt /

COPY test-credential-refresh.sh /


ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
ENV PATH=/hadoop/bin:/spark/bin:$PATH
ENV SPARK_NO_DAEMONIZE=1
ENV HADOOP_CONF_DIR=/hadoop/etc/hadoop
