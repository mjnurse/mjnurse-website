---
title: Running Spark on YARN - Cluster or Client Mode
---

Spark jobs can run on YARN in two modes: cluster mode and client mode. Understanding the difference between the two modes is important for choosing an appropriate memory allocation configuration, and to submit jobs as expected.

A Spark job consists of two parts:

- Spark Executors that run the actual tasks, and 
- a Spark Driver that schedules the Executors.

## Cluster Mode 

Everything runs inside the cluster. You can start a job from your laptop and the job will continue running even if you close your computer. In this mode, the Spark Driver is encapsulated inside the YARN Application Master.

## Client Mode 

The Spark driver runs on a client, such as your laptop. If the client is shut down, the job fails. Spark Executors still run on the cluster, and to schedule everything, a small YARN Application Master is created.

## Use Cases
Client mode is well suited for interactive jobs, but applications will fail if the client stops. For long running jobs, cluster mode is more appropriate.

<hr>
