---
title: Elasticsearch Caches
contents-list: h1,h2
---

At a high level, Elasticsearch has 3 caches:

- Page cache
- Shard-level request cache
- Query Cache

# Page Cache

The OS managed disk cache (sometimes called the file cache).  Caches blocks of data read from disk and can give a big increase in performance where there is lots of re-use.

# Shard-level Request Cache

This caches search responses consisting only of aggregations.  For a (Kibana style) query across logs captured in a set on indexes (say one per week), as the query window (time frame) moves forward, any indexes which sit entirely within for the old and new time frames do not need to be queries again, and aggregation values will stay the same.

This cache is enabled by default and can use up to 1% of the heap space.

To get stats on the use of the request cache:

```
GET /_nodes/stats/indices/request_cache?human
```

# Query Cache

This caches the results of a query but does so in a way which means the cached data can be reused between different queries.

For example, if we were to query a set of log indexes for a particular error message over a range of dates, a query cache could be used as follows.

If we assume the query is structured to:

- `match` where `"error_msg": "error 01: division by zero"`

and then:

- `filter` where `"range": {"datetime": {"gte": "22-02-01", "lt": "22-03-01"}}`

For the filter operation, elasticsearch might generate a `bit set` (bit array) which includes a single bit for each document which is set to `0` if the document doesn't fall in the date range and `1` if it does.

This `bit set` will be cached and will get reused in another query uses the same filter.

To get stats on the use of the query cache:

```
GET /_nodes/stats/indices/query_cache?human
```

