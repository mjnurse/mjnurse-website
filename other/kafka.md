---
title: What Is Kafka?

---

# Overview

*"A distributed event streaming platform capable of handling trillions of events a day. Initially conceived as a messaging queue, Kafka is based on an abstraction of a distributed commit log. Since being created and open sourced by LinkedIn in 2011, Kafka has quickly evolved from messaging queue to a full-fledged event streaming platform."*

## Topic

- A Topic is a collection of related messages / events.
- Reading from a Topic does not remove / delete the message from he Topic.
- Think of a Topic as a log file with pointers;
  - One write pointer always pointing to end of log.
  - 'N' read pointers (one per consumer).

## Partition

- A Topic is stored in N Partitions.
- Partitions are stored on and managed by Brokers.
- Can be thought of as a log (file) - although see Segments.

## Segment

- A Partition is stored as Segments (rolling log files) on disks.
- Note: A log is a file which can only be appended to, previous records immutable.

## Broker

- A Broker is an instance of Kafka running on a server (or VM or Docker etc).
- A Broker manages Partitions (and their Segments - log files).

# Kafka In Operation

## Producers

- Producers (1..many) write messages to Kafka.
- Messages are sent to a Topic.
- Producers get and ACK / NACK (negative ACK / error).

## Consumers

- Consumers (1..many) read messages from Kafka Topics.
- Reading from a Topic does not delete the message - messages persist based on retention policy.
- Each Consumer tracks its own offset (position) in the Topic.
- Consumers can read from any point in the Topic by setting their offset.

## Consumer Groups

- Multiple Consumers can work together as a Consumer Group.
- Each Consumer in a group reads from different Partitions.
- This enables parallel processing and load balancing.
- If a Consumer fails, another Consumer in the group takes over its Partitions.
- Each Consumer Group maintains its own offset per Partition.

## Message Ordering

- Messages within a single Partition are strictly ordered.
- No ordering guarantee across different Partitions.
- To ensure ordering, send related messages to the same Partition (using a key).

## Replication

- Partitions can be replicated across multiple Brokers for fault tolerance.
- One Partition replica is the Leader (handles all reads/writes).
- Other replicas are Followers (replicate data from the Leader).
- If the Leader fails, a Follower is promoted to Leader.
- Replication factor determines how many copies exist (e.g., RF=3 means 3 copies).

# Key Concepts

## Offset

- An Offset is the sequential ID of a message within a Partition.
- Starts at 0 and increments for each new message.
- Consumers track their current Offset to know which messages they've processed.
- Offsets are committed to Kafka to track progress.

## Retention

- Messages are retained for a configurable time period (e.g., 7 days) or size limit.
- After retention expires, old messages are deleted.
- Retention is independent of whether messages have been consumed.

## Keys and Partitioning

- Messages can have an optional key.
- Messages with the same key always go to the same Partition.
- If no key is provided, messages are distributed round-robin across Partitions.
- This ensures ordering for related messages.

## ZooKeeper (Legacy)

- Earlier Kafka versions required ZooKeeper for coordination and metadata management.
- ZooKeeper tracks Brokers, Topics, Partitions, and Consumer Groups.
- **KRaft Mode**: Kafka 3.0+ can run without ZooKeeper using built-in consensus.

# Common Use Cases

## Event Sourcing

- Store all state changes as a sequence of events.
- Rebuild application state by replaying events.

## Log Aggregation

- Collect logs from multiple services into centralized Topics.
- Process and analyze logs in real-time.

## Stream Processing

- Process data in real-time as it flows through Topics.
- Use Kafka Streams or external processors (Spark, Flink).

## Messaging Queue

- Decouple producers and consumers.
- Reliable message delivery with persistence.

## Metrics and Monitoring

- Collect application metrics and monitoring data.
- Real-time dashboards and alerting.

# Performance Characteristics

## High Throughput

- Can handle millions of messages per second.
- Sequential disk I/O for efficiency.
- Zero-copy optimization reduces CPU overhead.

## Low Latency

- Sub-millisecond latency for message delivery.
- Batching and compression for efficiency.

## Scalability

- Horizontal scaling by adding more Brokers and Partitions.
- Linear scaling with cluster size.

## Durability

- Messages are persisted to disk.
- Replication ensures no data loss.
- Configurable acknowledgment levels (acks=0, 1, all).

# Basic Commands

## Create Topic

```bash
kafka-topics.sh --create \
  --topic my-topic \
  --bootstrap-server localhost:9092 \
  --partitions 3 \
  --replication-factor 2
```

## List Topics

```bash
kafka-topics.sh --list \
  --bootstrap-server localhost:9092
```

## Describe Topic

```bash
kafka-topics.sh --describe \
  --topic my-topic \
  --bootstrap-server localhost:9092
```

## Produce Messages

```bash
kafka-console-producer.sh \
  --topic my-topic \
  --bootstrap-server localhost:9092
```

## Consume Messages

```bash
kafka-console-consumer.sh \
  --topic my-topic \
  --from-beginning \
  --bootstrap-server localhost:9092
```

## Consumer Groups

```bash
# List consumer groups
kafka-consumer-groups.sh --list \
  --bootstrap-server localhost:9092

# Describe consumer group
kafka-consumer-groups.sh --describe \
  --group my-group \
  --bootstrap-server localhost:9092
```

## Delete Topic

```bash
kafka-topics.sh --delete \
  --topic my-topic \
  --bootstrap-server localhost:9092
```

# Configuration Examples

## Producer Configuration

```properties
bootstrap.servers=localhost:9092
key.serializer=org.apache.kafka.common.serialization.StringSerializer
value.serializer=org.apache.kafka.common.serialization.StringSerializer
acks=all
retries=3
compression.type=snappy
```

## Consumer Configuration

```properties
bootstrap.servers=localhost:9092
group.id=my-consumer-group
key.deserializer=org.apache.kafka.common.serialization.StringDeserializer
value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
auto.offset.reset=earliest
enable.auto.commit=false
```

## Broker Configuration

```properties
broker.id=0
listeners=PLAINTEXT://localhost:9092
log.dirs=/var/kafka-logs
num.partitions=3
default.replication.factor=2
log.retention.hours=168
log.segment.bytes=1073741824
```

# Best Practices

## Topic Design

- Choose appropriate number of Partitions (more = higher parallelism).
- Consider message ordering requirements.
- Plan retention policies based on use case.

## Producer Best Practices

- Use appropriate `acks` setting (all for critical data).
- Enable idempotence to prevent duplicates.
- Batch messages for better throughput.
- Use compression (snappy, lz4, gzip).

## Consumer Best Practices

- Commit offsets after processing, not before.
- Handle rebalancing gracefully.
- Monitor consumer lag.
- Set appropriate `max.poll.records` and `max.poll.interval.ms`.

## Operational Best Practices

- Monitor disk space and I/O.
- Set up replication for fault tolerance.
- Use monitoring tools (JMX, Prometheus).
- Plan for capacity (disk, network, CPU).
- Regular backups of critical Topics.

# Monitoring Metrics

## Key Metrics to Monitor

- **Producer**: request latency, error rate, retry rate
- **Consumer**: lag, throughput, error rate, rebalance frequency
- **Broker**: request rate, disk usage, network throughput, under-replicated partitions
- **Cluster**: active controllers, offline partitions, ISR (In-Sync Replicas) count

# Summary

Kafka is a distributed streaming platform that excels at:
- High-throughput, low-latency message delivery
- Durable, persistent message storage
- Scalable, fault-tolerant architecture
- Real-time stream processing

Key components work together:
- **Producers** write to **Topics**
- **Topics** are divided into **Partitions**
- **Partitions** are stored as **Segments** on **Brokers**
- **Consumers** read from **Topics** using **Offsets**
- **Consumer Groups** enable parallel processing
- **Replication** ensures fault tolerance
