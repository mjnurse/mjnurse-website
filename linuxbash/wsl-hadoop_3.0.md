---
title: WSL - Hadoop 3.0
---

## HDFS Config

Datanode and Namenode directories default to `/tmp` - these didn't work for me (and not really a ideal location...).

`/c/MJN/wsl-hadoop-3.3.0/etc/hadoop/hdfs-site.xml`

```xml
<configuration>
        <property>
                <name>dfs.replication</name>
                <value>1</value>
        </property>
        <property>
                <name>dfs.datanode.data.dir</name>
                <value>/c/MJN/hdfs-data/datanode</value>
        </property>
        <property>
                <name>dfs.namenode.name.dir</name>
                <value>/c/MJN/hdfs-data/namenode</value>
        </property>
</configuration>
```

## Start / Stop HDFS / Yarn

`start-hadoop`

```bash
sudo service ssh restart
/c/MJN/wsl-hadoop-3.3.0/sbin/start-dfs.sh
/c/MJN/wsl-hadoop-3.3.0/sbin/start-yarn.sh
```

`stop-hadoop`

```bash
/c/MJN/wsl-hadoop-3.3.0/sbin/stop-dfs.sh
/c/MJN/wsl-hadoop-3.3.0/sbin/stop-yarn.sh
```

## Web Pages

dfs health: [http://localhost:9870/dfshealth.html](http://localhost:9870/dfshealth.html)

<hr>
