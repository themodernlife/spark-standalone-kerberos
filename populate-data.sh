#! /bin/bash



until kinit -kt /var/keytabs/hdfs.keytab hdfs/nn.example.com; do sleep 2; done

until (echo > /dev/tcp/nn.example.com/9000) >/dev/null 2>&1; do sleep 2; done


hdfs dfsadmin -safemode wait


hdfs dfs -mkdir -p /user/drwho/examples/src/main/resources
hdfs dfs -copyFromLocal /people.json /user/drwho/examples/src/main/resources
hdfs dfs -copyFromLocal /people.txt /user/drwho/examples/src/main/resources

hdfs dfs -chmod -R 755 /user/drwho
hdfs dfs -chown -R drwho /user/drwho


sleep 60