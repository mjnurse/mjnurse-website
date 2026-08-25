---
title: Snapshot and Restore To Different Cluster
contents-list: h1,h2
---

# Overview

Here we are using two single node Elasticsearch clusters - Cluster A (where we take indexes from - take a Snapshot), Cluster B (where we put the indexes - restore the Snapshot).

# Steps

## Configure Both Instances Ready For Snapshots

We need to specify the location on disk for the snapshot repositories and make sure these locations are accessible to Elasticsearch.  On Both Elasticsearch instances.

``` bash
> echo 'path.repo: ["/mnt/es_snapshot_repos"]' >> /etc/elasticsearch/elasticsearch.yml

> chown -R elasticsearch: /mnt/es_snapshot_repos

> chgrp -R elasticsearch: /mnt/es_snapshot_repos
```

Restart elasticsearch.

```bash
> systemctl restart elasticsearch
``` 

We now need to register a repository for snapshots on both instances.

```bash
> curl -X PUT "hosta:9200/_snapshot/mjn-repo?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/mnt/es_snapshot_repos"
  }
}
'

{
  "acknowledged" : true
}
```

## Create Snapshot on Elasticsearch Instance A

Create a snapshot with the same name as the other snapshot on NodeA;

```bash
> curl -X PUT "192.168.59.12:9200/_snapshot/mjn-repo/mjn_backup_20220612?pretty"

{
  "accepted" : true
}
```

Listing the contents of the repository directory;

```bash
ls -1 /mnt/mjn-repo/

-rwxr--r-- 1 elasticsearch elasticsearch 14272 Jun 10 15:00 index-0
-rwxr--r-- 1 elasticsearch elasticsearch     8 Jun 10 15:00 index.latest
drwxr-xr-x 1 elasticsearch elasticsearch   512 Jun 10 15:00 indices
-rwxr--r-- 1 elasticsearch elasticsearch   256 Jun 10 15:00 meta-GaiBfdzRQdi41xAedveMLQ.dat
-rwxr--r-- 1 elasticsearch elasticsearch  4543 Jun 10 15:00 snap-GaiBfdzRQdi41xAedveMLQ.dat
```

## Copy Snapshot Data from Host A Repository to Host B Repository

`scp` or whatever...

## Restart Elasticsearch on NodeB

We now need to restart elasticsearch on host B.

```bash
> systemctl restart elasticsearch
```  

## View Snapshot Information

Check the details about the snapshot;

```bash
> curl -X GET "hostb:9200/_snapshot/mjn-repo/mjn_backup_20220612?pretty"

{
  "snapshots" : [
    {
      "snapshot" : "emjn_backup_20220612",
      "uuid" : "33qzhT82QTmvH4GkWn-vhw",
      "version_id" : 7100099,
      "version" : "7.10.0",
      "indices" : [
  ...
}
```

The details should match those of the snapshot in the original node.

## Restore Elasticsearch Snapshot Instance B

We can now restore Elasticsearch snapshot data.

```bash
curl -X POST "hostb:9200/_snapshot/mjn_backup_20220612/_restore?pretty"
{
  "accepted" : true
}
```

<hr>
