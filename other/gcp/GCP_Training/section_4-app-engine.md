---
title: Section 4 - App Engine
contents-list: h1,h2
---

# Overview

Simple way to deploy and scale your applications in GCP.  Provides end-to-end application management.

Supports:

- Go, Java, .NET, Node.js, PHP, Python, Ruby using pre-configured runtimes.
- Use custom run-time and write code in any language.
- Connect to variety of Google Cloud storage products (Cloud SQL etc).

No usage charges - Pay for resources provisioned

Features:

- Automatic load balancing & Auto scaling.
- Managed platform updates & Application health monitoring.
- Application versioning.
- Traffic splitting.

# App Engine Environments

## Standard - Applications run in language specific sandboxes

- Complete isolation from OS/Disk/Other Apps.
- V1: Java, Python, PHP, Go (OLD Versions).
  - ONLY for Python and PHP runtimes: Restricted network Access, Only white-listed extensions and libraries are allowed.
  - No Restrictions for Java and Go runtimes.
- V2: Java, Python, PHP, Node.js, Ruby, Go (NEWER Versions).
  - Full Network Access and No restrictions on Language Extensions.

## Flexible - Application instances run within Docker containers

- Makes use of Compute Engine virtual machines.
- Support ANY runtime (with built-in support for Python, Java, Node.js, Go, Ruby, PHP, or .NET) so long as it can be made into a container.
- Provides access to background processes and local disks.

# Application Hierarchy

**Application** (one per project).

Contains one or more:

**Services** (previously called modules.  Each service can have different settings).
   
Contain one or more:

**Versions** (multiple versions of a service can be deployed with options to rollback and divide traffic).

Contain one or more:

**Instances** (multiple instances of each service version can be deployed).

# Standard vs Flexible Environments

Feature | Standard | Flexible
--------|----------|---------
Pricing Factors | Instance hours | vCPU, Memory & Persistent Disks
Scaling | Manual, Basic, Automatic | Manual, Automatic
Scaling to zero | Yes | No. Minimum one instance
Instance startup time | Seconds | Minutes
Rapid Scaling | Yes | No
Maximum request timeout | 1 to 10 minutes | 60 minutes
Local disk | Yes (except for Python, PHP). Can write to /tmp. | Yes. Ephemeral. New Disk on startup.
SSH (for debugging) | No | Yes

# Scaling Instances

3 types of scaling:

## Automatic Scaling

Recommended for Continuously Running Workloads.

- Auto scale based on:
  - Target CPU Utilization - Configure a CPU usage threshold.
  - Target Throughput Utilization - Configure a throughput threshold.
  - Max Concurrent Requests - Configure max concurrent requests an instance can receive.
- Configure Max Instances and Min Instances.

## Basic Scaling

- Instances are created as and when requests are received: Recommended for Adhoc Workloads.
- Instances are shutdown if ZERO requests (to keep costs low - high latency is possible).
- Configure Max Instances and Idle Timeout.

(NOT supported by App Engine Flexible Environment).

## Manual Scaling

Configure specific number of instances to run. Adjust number of instances manually over time.

