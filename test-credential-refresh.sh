#! /bin/bash

cat <<EOF > /tmp/test.py

import time
from pyspark.sql import SparkSession


spark = SparkSession.builder.appName("TEST").getOrCreate()

for i in range(100):
    spark.read.json("examples/src/main/resources/people.json").show()
    time.sleep(4)

EOF

spark-submit --principal drwho --keytab /var/keytabs/drwho.keytab --master spark://sm.example.com:7077 -c spark.yarn.credentials.file=/user/drwho/creds -c spark.yarn.security.credentials.hbase.enabled=false /tmp/test.py