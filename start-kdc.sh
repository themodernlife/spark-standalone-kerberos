#! /bin/bash

/usr/sbin/kdb5_util -P changeme create -s


## password only user
/usr/sbin/kadmin.local -q "addprinc  -randkey drwho"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/drwho.keytab drwho"
/usr/sbin/kadmin.local -q "addprinc  -randkey superman"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/drwho.keytab superman"

chown spark /var/keytabs/drwho.keytab



/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/server.example.com"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/server.keytab HTTP/server.example.com"




/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/nn.example.com"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/nn.example.com"
/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/dn1.example.com"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/dn1.example.com"
/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/dn2.example.com"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/dn2.example.com"

/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/nn.example.com"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/nn.example.com"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/dn1.example.com"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/dn1.example.com"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/dn2.example.com"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/dn2.example.com"

chown hdfs /var/keytabs/hdfs.keytab


keytool -genkey -alias nn.example.com -keyalg rsa -keysize 1024 -dname "CN=nn.example.com" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme
keytool -genkey -alias dn1.example.com -keyalg rsa -keysize 1024 -dname "CN=dn1.example.com" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme
keytool -genkey -alias dn2.example.com -keyalg rsa -keysize 1024 -dname "CN=dn2.example.com" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme
chmod 700 /var/keytabs/hdfs.jks
chown hdfs /var/keytabs/hdfs.jks


krb5kdc -n