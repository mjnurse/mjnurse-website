---
title: Read and Query a Parquet File in a Spark Shell
---

## Basic Read and Query

```scala
// Read in file to a data frame.
> val df = spark.read.parquet("filename.parquet")

// Print the data frame schema.
> df.printSchema()

// Show the data.
> df.show()

// Number of records.
> df.count()
```

## Spark SQL

```scala
// Read in file to a data frame.
> val df = spark.read.parquet("filename.parquet")

// Create a temporary view over the dataframe
> df.createOrReplaceTempView("dfv") // dfv - data frame view

// Run SQL Select query
> val res=spark.sql("SELECT * FROM dfv")
> res.show()
```

Show more data:

```scala
df.show() // Show 20 rows & 20 characters for columns
df.show(50) // Show 50 rows
df.show(false) // Show 20 rows with full column value
df.show(50,false) // Show 50 rows & full column value
df.show(20,20,true) // Show 20 rows, column length 20 & displays data in vertical
```

