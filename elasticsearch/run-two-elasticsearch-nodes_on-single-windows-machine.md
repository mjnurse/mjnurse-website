---
title: Run Two Elasticsearch Nodes on Single Windows Machine
---

To run two Elasticsearch nodes on a single windows machine means running two instances of the Elasticsearch application.

Each instance of Elasticsearch needs a separate `elasticsearch.yml` config file.  This file is located in the Elasticsearch `config` directory.

### Node 1

`elasticsearch.yml`

```yml
cluster.name: mjn-cluster
node.name: node-1
http.port: 9200
transport.port: 9300
discovery.seed_hosts: ["127.0.0.1:9301"]
cluster.initial_master_nodes: ["node-1", "node-2"]
path.data: C:\\mjn\\elasticsearch-7.17.9\\data-node-1
path.logs: C:\\mjn\\elasticsearch-7.17.9\\logs-node-1
```

### Node 2

`elasticsearch.yml`

```yml
cluster.name: mjn-cluster
node.name: node-2
http.port: 9201
transport.port: 9301
discovery.seed_hosts: ["127.0.0.1:9300"]
cluster.initial_master_nodes: ["node-1","node-2"]
path.data: C:\\mjn\\elasticsearch-7.17.9\\data-node-2
path.logs: C:\\mjn\\elasticsearch-7.17.9\\logs-node-2
```

I had hoped to create these as two files in the same `config` directory and specify the config file to use when starting the Elasticsearch instance - eg:

```
> C:\mjn\elasticsearch-7.17.9\bin\elasticsearch.bat -E path.conf=<path-to-config-file>
```

To get around this I created two copies of the config directory:

```sh
$ dir config*

config-node-1:
elasticsearch-plugins.example.yml  elasticsearch.yml  jvm.options.d      role_mapping.yml  users
elasticsearch.keystore             jvm.options        log4j2.properties  roles.yml         users_roles

config-node-2:
elasticsearch-plugins.example.yml  elasticsearch.yml  jvm.options.d      role_mapping.yml  users
elasticsearch.keystore             jvm.options        log4j2.properties  roles.yml         users_roles
```

In GitBash I ran the two instances as follows, first setting the environment variable `ES_PATH_CONF`:

```bash
export ES_PATH_CONF=/c/MJN/elasticsearch-7.17.9/config-node-1; elasticsearch.bat &
export ES_PATH_CONF=/c/MJN/elasticsearch-7.17.9/config-node-2; elasticsearch.bat &
```

