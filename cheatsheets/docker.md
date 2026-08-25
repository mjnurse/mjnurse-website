---
title: Docker CheatSheet
---

# Overview

| Command | Description |
|---------|-------------|
| `> docker search <name>`          | Search for a docker image to download. |
| `> docker images`                 | List the images downloaded and available. |
| `> docker pull <name>`            | Download the image. |
| `> docker rmi <name>`             | Delete an image. |


# Elasticsearch in a Container

`> docker pull docker.elastic.co/elasticsearch/elasticsearch:7.9.3`

`> docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.9.3`


# PostgreSQL in a Container

`> docker pull postgres`

`> docker run --name mjn-postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres`

`> sudo apt-get install postgresql-client-12`

(Note may need to add extra repos to apt-get)

```bash
#!/bin/bash
export PGPASSWORD=postgres

if [[ "$1" == "" ]]; then
   psql --host=localhost -U postgres $*
else
   psql --host=localhost -U postgres -f $1
fi
```

# Oracle in a Container

Note:  Ideally the data would be stored in a folder on the client but Docker on windows using Azure Active Directory will not mount external folders...

```bash
> docker run -d --name oracle --privileged -p 8080:8080 -p 1521:1521 absolutapps/oracle-12c-ee 
```

<hr>
