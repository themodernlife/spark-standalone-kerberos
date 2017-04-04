
## WORK IN PROGRESS


#1. Configure Docker networking

Hadoop requires reverse DNS.  Under docker-compose, we require an external network named "com" for hosts to resolve forward and backwards.

```
docker network create com
```

#2. Download a distro of Hadoop and Spark

To keep the repo size small, `hadoop-2.7.3.tar.gz` and `spark-2.2.0-SNAPSHOT-bin-2.7.3.tgz` are not included.  Download them from the internet.


#3. Start it up

```
# make sure no data from previous runs exists
docker volume rm kerberosenv_server-keytab
docker-compose up -d --force-recreate --build
```

#4. Run some spark jobs

You can run spark jobs in local mode as `drwho`

```
docker exec -it driver.example /bin/bash
kinit -kt /var/keytabs/drwho.keytab drwho
spark-shell
```

#5. Run HDFS commands

```
docker exec -it nn.example /bin/bash
kinit -kt /var/keytabs/hdfs.keytab hdfs/nn.example.com
hdfs dfs -ls
```

#6. Test out the patch for SPARK-5158

```
docker exec -it driver.example /bin/bash
spark-shell --principal drwho --keytab /var/keytabs/drwho.keytab --master spark://sm.example.com:7077 -c spark.yarn.credentials.file=/user/drwho/creds -c spark.yarn.security.credentials.hbase.enabled=false
```





