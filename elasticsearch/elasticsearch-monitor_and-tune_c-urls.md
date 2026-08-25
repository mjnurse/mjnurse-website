---
title: Elasticsearch Monitor and Tune cURLS
contents-list: h1,h2
---

# Monitoring

## General monitoring API endpoints

| Stats from all nodes | `curl 'localhost:9200/_nodes/stats'` |
| Stats from specific nodes | `curl 'localhost:9200/_nodes/node1,node2/stats'` |
| Stats from a specific index | `curl 'localhost:9200/<INDEX_NAME>/_stats'` |
| Cluster-wide stats | `curl 'localhost:9200/_cluster/stats'` |

## Cluster health

| Cluster status & unassigned shards | `curl 'localhost:9200/_cat/health?v'` |

## Search performance

| Total number of queries | `curl 'localhost:9200/_cat/nodes?v&h=name,searchQueryTotal'` |
| Total time spent on queries | `curl 'localhost:9200/_cat/nodes?v&h=name,searchQueryTime'` |
| Number of queries currently in progress | `curl 'localhost:9200/_cat/nodes?v&h=name,searchQueryCurrent'` |
| Total number of fetches | `curl 'localhost:9200/_cat/nodes?v&h=name,searchFetchTotal'` |
| Total time spent on fetches | `curl 'localhost:9200/_cat/nodes?v&h=name,searchFetchTime'` |
| Number of fetches currently in progress | `curl 'localhost:9200/_cat/nodes?v&h=name,searchFetchCurrent'` |

## Indexing performance

| Total number of documents indexed | `curl 'localhost:9200/_cat/nodes?v&h=name,indexingIndexTotal'` |
| Total time spent indexing documents | `curl 'localhost:9200/_cat/nodes?v&h=name,indexingIndexTime'` |
| Number of documents currently being indexed | `curl 'localhost:9200/_cat/nodes?v&h=name,indexingIndexCurrent'` |
| Total number of index flushes to disk | `curl 'localhost:9200/_cat/nodes?v&h=name,flushTotal'` |
| Total time spent on flushing indices to disk | `curl 'localhost:9200/_cat/nodes?v&h=name,flushTotalTime'` |

## JVM heap usage

| Garbage collection frequency and duration | `curl 'localhost:9200/_nodes/stats/jvm' ` |
| Percent of JVM heap currently in use | `curl 'localhost:9200/_cat/nodes?v&h=name,heapPercent'` |

## Pending tasks

| Number of pending tasks | `curl 'localhost:9200/_cluster/pending_tasks'` |

## Thread pool queues & rejections

| Number of queued threads in a thread pool | `curl 'localhost:9200/_nodes/stats/thread_pool' ` |
| Number of rejected threads in a thread pool | `curl 'localhost:9200/_nodes/stats/thread_pool' ` |

## Fielddata cache usage

| Size of the fielddata cache (bytes) | `curl 'localhost:9200/_cat/nodes?v&h=name,fielddataMemory'` |
| Number of evictions from the fielddata cache | `curl 'localhost:9200/_cat/nodes?v&h=name,fielddataEvictions'` |
| Number of times the fielddata circuit <br>breaker has been tripped (ES version >=1.3) | `curl 'localhost:9200/_nodes/stats/breaker' ` |

## Host-level network and system metrics

| Disk space total, free, available | `curl 'localhost:9200/_nodes/stats/fs' ` |
| Percent of disk in use | `curl 'localhost:9200/_cat/allocation?v'` |
| Memory | `curl 'localhost:9200/_nodes/stats/os'` |
| CPU | `curl 'localhost:9200/_nodes/stats/os'` |
| Used file descriptors percentage | `curl 'localhost:9200/_cat/nodes?v&h=host,name,fileDescriptorPercent' ` |
| Network bytes sent/received | `curl 'localhost:9200/_nodes/stats/transport' ` |
| HTTP connections currently open & total opened over time | `curl 'localhost:9200/_nodes/stats/http' ` |

## Default directories

|  | DEBIAN/UBUNTU | RHEL/CENTOS | ZIP OR TAR INSTALLATION |
| Configuration | `/etc/elasticsearch` | `/etc/elasticsearch` | `<ES INSTALL HOME DIR>/config` |
| Logs | `/var/log/elasticsearch` | `/var/log/elasticsearch` | `<ES INSTALL HOME DIR>/logs` |
| Data | `/var/lib/elasticsearch/data` | `/var/lib/elasticsearch` | `<ES INSTALL HOME DIR>/data` |

# Tuning

## Unassigned shards

| Check which shards are unassigned | `curl 'localhost:9200/_cat/shards' | grep UNASSIGNED` |

**Suggested Action**

- Reduce number of replicas for an index (master will not assign multiple copies of a shard on the same node).

```bash
curl -XPUT 'localhost:9200/<INDEX_NAME>/_settings' -d '{"number_of_replicas": <DESIRED NUMBER OF REPLICAS>}'
```

- Re-enable shard allocation 

```bash
curl -XPUT 'localhost:9200/_cluster/settings' -d '{"transient": {"cluster.routing.allocation.enable": "all"}}'
```

- Manually allocate an unassigned shard 

```bash
curl -XPOST 'localhost:9200/_cluster/reroute' \
     -d '{"commands": [{"allocate": {"index": "<INDEX_NAME>", 
                                     "shard": <SHARD_NUMBER>,
                                     "node": "<NODE_NAME>"}}]}'
```

- Check disk usage; master node will not assign shards to any node using >85% of disk

```bash
curl 'localhost:9200/_cat/allocation?v'
```

- Check that every node is running the same version of Elasticsearch; master node will not assign to older version

```bash
curl 'localhost:9200/_cat/nodes?v&h=host,name,version'
```

## Search performance

Log slow queries in slow search log (replace with your desired thresholds):

```bash
curl -XPUT 'localhost:9200/<INDEX_NAME>/_settings' -d '{
 "index.search.slowlog.threshold.query.warn" : "10s",
 "index.search.slowlog.threshold.fetch.debug": "500ms",
 "index.indexing.slowlog.threshold.index.info": "5s"
}'
```

**Suggested Action**

- Route high-priority, low-volume documents of a <DOC_TYPE> to the same place so only one shard will be queried

```bash
curl -XPUT 'localhost:9200/<INDEX_NAME>' \
     -d '{"mappings": {"<DOC_TYPE>": {"_routing": {"required": true}}}}'
```

- Merge segments in an index ES versions 2.1.0+

```bash
curl -XPOST 'localhost:9200/<INDEX_NAME>/_forcemerge'
```

## Indexing performance

**Suggested Action**

- Bulk index documents from a JSON file

```bash
curl -XPOST 'localhost:9200/<INDEX_NAME>/<MY_TYPE>/_bulk?pretty' --data-binary "@<YOUR_FILE>.json"
```

- Increase refresh interval to optimize indexing, rather than making new data immediately searchable

```bash
curl -XPUT 'localhost:9200/<INDEX_NAME>/_settings' \
     -d '{"index": {"refresh_interval": DESIRED_INTERVAL, e.g. "30s"}}'
```

- Disable merge throttling to leave more resources for indexing, not merging

```bash
curl -XPUT 'localhost:9200/_cluster/settings' \
     -d '{"transient": {"indices.store.throttle.type": "none"}}'
```

- Disable shard replication 

```bash
curl -XPUT 'localhost:9200/<INDEX_NAME>/_settings' \
     -d '{"number_of_replicas": 0}'
```

- Commit translog to disk less frequently 

```bash
curl -XPUT 'localhost:9200/<INDEX_NAME>/_settings' \
     -d '{"index": {"translog": {"durability": "async"}}}'
```

## Tune the JVM heap size.

*Note*: The Elasticsearch docs recommend setting your heap size below 50% of a node's available memory (and never going above 32GB), to leave more memory for the file system cache).

**Suggested Action**

- Set heap size upon starting up Elasticsearch 

```bash
ES_HEAP_SIZE=DESIRED_SIZE (e.g. "3g")
./bin/elasticsearch
```

- Set heap as an environment variable (requires Elasticsearch restart) 

```bash
export ES_HEAP_SIZE=DESIRED_SIZE (e.g. 3g)
```

## Fielddata usage

**Suggested Action**

Enable doc values for a non-analyzed string field (enabled by default for ES versions 2.0+)

```bash
curl -XPUT 'localhost:9200/<INDEX_NAME>/_mapping/<DOC_TYPE>' \
     -d '{"properties": {"<FIELD_NAME>": {"type": "string", 
        "index": "not_analyzed", "doc_values": true }}}'
```

