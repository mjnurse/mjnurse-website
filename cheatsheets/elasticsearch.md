---
title: Elasticsearch Cheat Sheet
---

# Using Curl

```bash
# Note: '?v' add headers to the table of results.
> curl --request GET http://localhost:9200/_cat/health?v  

# Passing JSON into the curl
> curl --request GET http://localhost:9200/_search -H 'Content-Type: application/json' -d '{ <json> }'
```

# Utilities

```bash
# Index details
GET _cat/<indices|shards|segments>/<index name (wildcards allowed)>?v

# Force Merge segments
POST /<index name>/_forcemerge?[max_num_segments=<num>]&[only_expunge_deletes=<true|false>]

# List running tasks / cancel a task (find a reindex task and cancel it).
GET _tasks?actions=*reindex*&detailed
POST _tasks/oTUltX4IQMOUUVeiohTt8A:12345/_cancel
```

# Create

```bash
PUT <index-name>
{
    "settings" : {
        "index" : {
            "number_of_shards" : 3, 
            "number_of_replicas" : 2 
        }
    }
}
```

## Create a Copy of an Index

```bash
POST _reindex
{
  "source": {
    "index": "<current index name>"
  },
  "dest": {
    "index": "<new index name>"
  }
}
```

Note the new index can already exist.  Can also add a query to the source or specify a type to filter the documents copied.

# Insert

```bash
POST /<index>/<type use:default>
{
   "name" : "martin",
   "age" : 21
}
```

## Bulk Insert

Note: Newlines are important separators for each command and data JSON statement.

```bash
POST /<index>/<type use:default>/_bulk
{ "index" : { } }
{ "name" : "bill", "age" : 43 }
{ "index" : { } }
{ "name" : "carl", "age" : 12 }
etc...
```

# Search

```bash
GET <index>/_search 
{ <json> }
```

## JSON Can Include Sections Which

## Specify the fields returned

```bash
{ "_source" : [ "<path>.<field>" ], "query" : { ... } }
```

## Alter number of results

```bash
{ "from" : 0, "size" : 10000 }
```

## JSON Query Definitions

### Wildcard Queries

```bash
{ "query" : { "wildcard" : { "<path>.<field>" : "<search_string>*" } } }
```

### Matching a Value or a List of Values

```bash
{ "query" : { "term" : { "<path>.<field>" : "<search_string>" } } }
{ "query" : { "terms" : { "<path>.<field>" : ["<search_string1>", "<search_string2>"] } } }
```

### Matching One or More of Many Terms

```bash
{ "query" : 
   { "dis_max" : 
      { "queries" : 
         [  { "term": { "<path>.<field>" : "<search_string>" } }, 
            { "term": { "<path>.<field>" : "<search_string>" } } 
         ]
      } 
   } 
}
```

### Boolean Queries

OR  > should
AND > must
NOR > should_not

```bash
{ "query": {
    "bool": {
      "must": [
        {
          "term": {"shape": "round"}
        },
        {
          "bool": {
            "should": [
              {"match": {"color": "red"}},
              {"match": {"color": "blue"}
            ]
          }
        }
      ]
    }
  }
}

```

# Multi Search

Note: Newlines are important separators for each command and data JSON statement.

```bash
GET <index>/_msearch 
{ "index" : "<index>" }
{ "query" : { "terms" : { "<path>.<field>" : ["<search_str1>", "<search_str2>"] } } }
{ "index" : "<index>" }
{ "from" : 0, "size" : 10000, "query" : { "terms" : { "<path>.<field>" : ["<srch_str3>", "<srch_str4>"] } } }
etc...
```

# Scrolling Search Results

A walk-through example:

```bash
# 1. Create an index
PUT /mjn/default/_bulk
{"index":{}}
{"word":"one"}
{"index":{}}
{"word":"two"}
{"index":{}}
{"word":"three"}
{"index":{}}
{"word":"four"}
{"index":{}}
{"word":"five"}

# 2. Search the index, requesting the scroll_id and specifying the size of the dataset to be returned.
#    The search results will include a _scroll_id field.
#    (scroll=1m requests that the search context be kept alive for 1 minute).
GET /mjn/_search?scroll=1m
{"size":2}

# 3. Call the scroll API to get the next batch of results.  Can call this until no more hits returned.
POST /_search/scroll
{ "scroll":"1m",
  "scroll_id": "<scroll id>" }
```


<hr>
