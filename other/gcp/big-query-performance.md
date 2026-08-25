---
title: GCP BigQuery Performance
---

## Background

BigQuery is built on Googles Colossus filesystem and Dremel massively distributed query engine.  BigQuery is a Columnar database / datastore.

Queries are split and run over many worker nodes, called slots.  The 'shuffle', where slots share data, runs over the Google high performance network.

## Loading / Linking Data

Data can be loaded into or linked to BQ.  Queries over loaded data is more performant.  

Data can be linked from Cloud Storage (CS), currently stored in csv, Avro, JSON or Data Store backup format.  BQ can also link direct to google analytics and google suite (eg sheets).

### Batch Loading Data

Best practice is to copy data to CS and then load to BQ.  Command line 'bq' tool is efficient load tool.

### Streaming Data

Data can be Streamed into BQ from PubSub via Cloud Dataflow.  Alternatively the BQ API can be used, perhaps from Python, Go, Scala.

## Query Performance / Cost ($)

**Note:** +COST means beneficial in terms of cost.  +PERF means beneficial in terms of performance.

- Avoid `SELECT *`.  BQ is columnar so only read columns needed.

- `WHERE` and `LIMIT` can reduce data returned (+PERF) but will not reduce Cost as all data is scanned.  `LIMIT` can reduce data to sort (+PERF).

- Consider **materialising** (a super set of) frequently filtered data (+PERF,+COST).

- **Partitioning** a table allows data to be excluded from the scan (+PERF,+COST).

- Common Table Expressions (CTEs) i.e data from queries using the `WITH` clause are not materialised so if they are used several times, data will be read several times.  Consider Materialising.

- **Approximation Functions** eg. `APPROX_COUNT_DISTINCT()` or HyperLogLog++ functions eg. `HLL_COUNT.EXTRACT()` can reduce cost and improve performance (+PERF,+COST).

- To **preview data** use the UI option, API `tabledata.list` or `> bq head` command and avoid `SELECT * ... LIMIT`.

- **Filter Early** - For example use `WHERE` to filter data before aggregation rather than the `HAVING` on aggregated data.  Less data gets shuffled (+PERF).

- **Join Clause Optimisation** - Largest table first.  Follow this by smallest table then all other tables in descending size order (+PERF).  This may allow a **Broadcast Join** to be used where the contents of the small table are sent to all Slots.

- **Wildcard Tables Filter** - When using wildcard table names (eg `FROM mjn_date_*`) data reads can be avoided by using the `WHERE _TABLE_SUFFIX` filter eg. `WHERE _TABLE_SUFFIX = "2017"` (+PERF,+COST).

- **Analytic Functions** (inc. window functions) can avoid multiple scans of a single table (+PERF,+COST).

- `ORDER BY` typically runs on very few (or a single) Slot so run this last (and use `LIMIT` to reduce rows sorted) (+PERF).

- **Materialise Common Joins** - could also reduce data volume read (+PERF,+COST).

- Avoid User Defined Functions (UDFs) - these needs a context switch to the Javascript engine (V8 - Googles JS engine) and don't typically parallelise well (+PERF).

- **Avoid Skew** - use an equality join to rectify when possible.  eg. `CASE WHEN k IS NOT NULL THEN k ELSE '#'||other_col` (+PERF).

- **De-Normalise Data** - Use **Nesting** (array columns) instead (+PERF).

- Consider **Sharding** using wildcard table names where partitioning is not possible.  Use the `WHERE _TABLE_SUFFIX` as described above.

## Updates

- Avoid single row updates, columnar data does not suit this.

- Often best to avoid all updates, consider building a new table and drop existing.
<hr>
