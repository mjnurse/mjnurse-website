---
title: Spark Cheatsheet
---

# Client / Cluster Mode

Cluster mode create an Application Monitor container in the cluster.  Client mode run the application locally.

# Data Frame API Categories

## Transformations

### Narrow Dependency

Performed in parallel on partitions eg. `select()`, `filter()`, `drop()`, `withColumn()`

### Wide Dependency

Performed after grouping data from multiple partitions eg. `groupBy()`, `join()`, `cube()`, `rollup()`, `agg()`, `repartition()`

## Actions

Trigger a job eg. `read()`, `write()`, `collect()`, `take()`, `count()`

## Job Execution Plans

Logical execution plans are broken by wide dependencies -> stages - these are separated by shuffle/sorts.

If an executor has multiple cores then we call these multiple slots.  Each slot can process a partition.

# Memory Allocation

## Spark Driver

`spark.driver.memory` - this is the memory allocated to the Spark driver.

`spark.driver.memoryOverhead` - Container process or other none JVM processes in the container.  This is a percentage and the minimum allocated is `max(spark.driver.memoryOverhead * spark.driver.memory, 384MB)`.


# PySpark

```python
# Dataframe to JSON (string)
jsonStrings = df.toJSON().collect()

# Dataframe to list
list = [row.asDict() for row in df.collect()]
for row in list:
      print(row)

# Create dataframe from list - need to define schema
df = spark.createDataFrame(list, schema)

# Get the schema definition for a dataframe
schema = df.schema
print(schema)
```

