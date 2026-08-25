---
title: Quick and Easy Creation of an Oracle Database in Docker
---

Google led me to a container image `alexeiled/docker-oracle-xe-11g`.  An old version but, xe is light weight, and does what I need.  For a full set of Oracle containers Oracle has a GitHub repository: [github:oracle](https://github.com/oracle/docker-images).

I'm running Docker Desktop on Windows 10.

## Get the Image

```bash
> docker pull alexeiled/docker-oracle-xe-11g
```

## Create a Container

Open two network ports, one of the oracle client (1521), the other for the oracle web tool (8080).

```bash
> docker run -d --shm-size=2g --name oracle-xe -p 1521:1521 -p 8080:8080 alexeiled/docker-oracle-xe-11g
...

> docker container -ls
CONTAINER ID        IMAGE                            COMMAND                  CREATED             STATUS
PORTS                                            NAMES
e93f1a668767        alexeiled/docker-oracle-xe-11g   "/bin/sh -c /start.sh"   37 seconds ago      Up 35 seconds
0.0.0.0:1521->1521/tcp, 0.0.0.0:8080->8080/tcp   oracle-xe
```

The oracle container is now running and accessible.

**An aside:** I wanted to mount a local file share inside the container for oracle sql scripts etc.  But, docker doesn't play well with Azure Active Directory so I skipped this for now.  The syntax to include a local file share is `--volume c:/MJN/oracle/scripts`.

## Connecting to Oracle

I have the Oracle client installed locally - see elsewhere if you need to install this.

I opened the Docker Desktop Settings window and by going to the Network tab established the Internal Virtual Switch Network address is the default 10.0.75.0.  This can also be checked using ipconfig:

```bash
> ipconfig

Windows IP Configuration
...
Ethernet adapter vEthernet (DockerNAT):
   Connection-specific DNS Suffix  . :
   Link-local IPv6 Address . . . . . : fe80::e15d:ce41:7ba4:190f%27
   IPv4 Address. . . . . . . . . . . : 10.0.75.1
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . :
...
```

Run the sqlplus client and connect.

```bash
c:\MJN\oracle_client>sqlplus /nolog

SQL*Plus: Release 18.0.0.0.0 - Production on Mon Feb 25 12:35:49 2019
Version 18.3.0.0.0

Copyright (c) 1982, 2018, Oracle.  All rights reserved.

SQL> conn system/oracle@//10.0.75.1:1521/xe

Connected.

system@XE(100) >
```

## Connecting to the Oracle Server OS

To complete the overview, to connect to the Oracle server OS:

```bash
> docker exec -it oracle-xe /bin/bash

root@e93f1a668767:/#
```

<hr>
