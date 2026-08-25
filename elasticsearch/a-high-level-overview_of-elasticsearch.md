---
title: A High Level Overview of Elasticsearch
---

# Structure

- Elasticsearch creates, manages and searches **Indexes**.  

- **Indexes** are stored on **Nodes**.

- Multiple **Nodes** make up a **Cluster**.

- A **Cluster** is identified by a unique name.

- A **Node** is a member of one **Cluster** and is identified by a name (defaulting to a random UUID - Universally Unique Identifier).

- A **Node** runs on a **Server**, a **Server** can host multiple **Nodes**.

- **Indexes** are (logically and physically) split into **Shards** (horizontal scaling).

- Multiple replicas of a **Shard** can be created (vertical scaling).  Replicas can protect against **Server** loss / outage.

- One or more **Shards** are written to a **Node**.

- Each **Shard** is a **Lucene Index**. 

- Each Lucene **Index** is split into **Segments**.

- A **Segment** is created when a write opens, commits or closes.

- **Segments** are immutable.

- **Segments** are akin to mini **Indexes**.

- Lucene **Indexes** are 'Inverted Indexes' - terms map to documents (document ids and perhaps locations within).

Terms are stored in alpha-numeric order and can be stored in a number of formats.  An ordered lists of terms is good for finding `word*` but not `*word` (which would mean searching all terms).  To support performant `*word` searches, terms are also stored in reverse order.  Other manipulations of terms are done to support other complex searches - for example geo-location, number ranges and more.

Historically, Elasticsearch contained **Mapping Types**.  These a being deprecated from v6.0.0 onwards.  **Mapping Types** described the format of **Documents** in an **Index** and an **Index** could contain multiple **types**.  From v6.0.0 onwards an **Index** can only contain a single **Document type**.  This is typically called `_doc` but can be given a different name.

# Operations

## Add Document: 

- Add new Document requests are first appended to a 'transaction log' (a fast operation ).  Documents are then indexed (slower operation).

- When new Documents are added to an Index, they are first stored in memory and then Flushed to disk as a new Index Segment.

- Documents are added to the Index (as new Segments) in batches (using the DocumentWriter).

- Using default Routing, Documents are stored on (routed to) a Shard based on a document id hash.

- Custom routing can be used to Route documents to a particular Shard (and it's replica) based on a mapping (for example document author).

## Delete Document: 

- To Delete a document from the index, the document is marked as deleted in a (bitmap) file.'

## Update Document: 

- Index updates are a Delete (flagged as deleted) and an Insert (into a new Segment).

# Search

- STEP 0: Check the query cache for results.

- STEP 1: The query is sent to either all Shards (default Routing) or a particular Shard (Custom Routing).

- STEP 2: Within a shard, all Index Segments are read **Sequentially** for the search term(s).

- STEP 3: Any documents flagged as deleted are removed from the results.

# Percolator

Think of this as the reverse operation of what elasticsearch does by nature: instead of sending docs, indexing them, and then running queries, one sends queries, registers them, and then sends docs and finds out which queries match that doc.

# Maintenance

## Index Segment Merges (automatic - but can be triggered using the API)

- Lucene will automatically Merge Segments (removing Deleted documents in the process).

- A number of index settings can alter when Segments are Merged.  

- Merging effort needs to be balanced against Search effort (over multiple segments).

# Slow Queries

A good way to know which queries take the more time is by using Elasticsearch slow queries logs.

```
PUT /index/_settings 
{
    "index.search.slowlog.threshold.query.warn: 1s",
    "index.search.slowlog.threshold.query.info: 500ms",
    "index.search.slowlog.threshold.query.debug: 1500ms",
    "index.search.slowlog.threshold.query.trace: 300ms",
    "index.search.slowlog.threshold.fetch.warn: 500ms",
    "index.search.slowlog.threshold.fetch.info: 400ms",
    "index.search.slowlog.threshold.fetch.debug: 300ms",
    "index.search.slowlog.threshold.fetch.trace: 200ms"
}
```
<hr>
