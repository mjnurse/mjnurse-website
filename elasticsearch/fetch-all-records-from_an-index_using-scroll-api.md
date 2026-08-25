---
title: Fetch All Records From an Index using Scroll API
---

A bash script to fetch all records from an Elasticsearch index.

```bash
#!/bin/bash

# Scroll through all records in index 'mjn-tiny', reading 5 records at a time.
index=mjn-tiny
query_size=5

tmp1=$0.tmp1
tmp2=$0.tmp2

# Run initial search/fetch (no search criteria).  "sort": ["_doc"] is an Elasticsearch
# recommended performance setting.  Request a scroll key, set lifespan to 1 minute.
curl -s -X GET http://localhost:9200/$index/_search?scroll=1m \
     -H 'Content-Type: application/json' -d '
{
  "size":'$query_size',
  "sort": ["_doc"]
}
' > $tmp1

# Show the hits (index records).
cat $tmp1 | jq -c '.hits | .hits'
echo "--------------------"

# Extract the scroll id.
scroll_id="$(cat $tmp1 | jq '._scroll_id')"

# An endless loop.
while [ 1 ]; do

  # Run a scroll query using the scroll id.
  curl -s -X POST http://localhost:9200/_search/scroll \
       -H 'Content-Type: application/json' -d '
  {
    "scroll" : "1m",                                                                 
    "scroll_id" : '$scroll_id'
  }
  ' > $tmp1

  # Extract the hits (index records).
  cat $tmp1 | jq -c '.hits | .hits' > $tmp2

  # If the hits (JSON array) is empty then we have reached the end of the records, so exit.
  if [[ "$(cat $tmp2)" == "[]" ]]; then
    echo "Done!"
    exit
  fi
  cat $tmp2
  echo "--------------------"
done

rm -f $tmp1 $tmp2
```

Running the script.

```bash
> fetch_all

[{"_index":"mjn-tiny","_type":"_doc","_id":"CZIpgYsBOIyX700AWp8p","_score":null,"_source":{"set":0,"
num":0},"sort":[0]},{"_index":"mjn-tiny","_type":"_doc","_id":"CpIpgYsBOIyX700AWp8p","_score":null,"
_source":{"set":0,"num":1},"sort":[1]},{"_index":"mjn-tiny","_type":"_doc","_id":"C5IpgYsBOIyX700AWp
8p","_score":null,"_source":{"set":0,"num":2},"sort":[2]},{"_index":"mjn-tiny","_type":"_doc","_id":
"DJIpgYsBOIyX700AWp8p","_score":null,"_source":{"set":0,"num":3},"sort":[3]},{"_index":"mjn-tiny","_
type":"_doc","_id":"DZIpgYsBOIyX700AW58o","_score":null,"_source":{"set":1,"num":0},"sort":[4]}]
--------------------
[{"_index":"mjn-tiny","_type":"_doc","_id":"DpIpgYsBOIyX700AW58o","_score":null,"_source":{"set":1,"
num":1},"sort":[5]},{"_index":"mjn-tiny","_type":"_doc","_id":"D5IpgYsBOIyX700AW58o","_score":null,"
_source":{"set":1,"num":2},"sort":[6]},{"_index":"mjn-tiny","_type":"_doc","_id":"EJIpgYsBOIyX700AW5
8o","_score":null,"_source":{"set":1,"num":3},"sort":[7]},{"_index":"mjn-tiny","_type":"_doc","_id":
"EZIpgYsBOIyX700AW5-M","_score":null,"_source":{"set":2,"num":0},"sort":[8]},{"_index":"mjn-tiny","_
type":"_doc","_id":"EpIpgYsBOIyX700AW5-M","_score":null,"_source":{"set":2,"num":1},"sort":[9]}]
--------------------
[{"_index":"mjn-tiny","_type":"_doc","_id":"E5IpgYsBOIyX700AW5-M","_score":null,"_source":{"set":2,"
num":2},"sort":[10]},{"_index":"mjn-tiny","_type":"_doc","_id":"FJIpgYsBOIyX700AW5-M","_score":null,
"_source":{"set":2,"num":3},"sort":[11]},{"_index":"mjn-tiny","_type":"_doc","_id":"FZIpgYsBOIyX700A
XJ8A","_score":null,"_source":{"set":3,"num":0},"sort":[12]},{"_index":"mjn-tiny","_type":"_doc","_i
d":"FpIpgYsBOIyX700AXJ8A","_score":null,"_source":{"set":3,"num":1},"sort":[13]},{"_index":"mjn-tiny
","_type":"_doc","_id":"F5IpgYsBOIyX700AXJ8A","_score":null,"_source":{"set":3,"num":2},"sort":[14]}
]
--------------------
[{"_index":"mjn-tiny","_type":"_doc","_id":"GJIpgYsBOIyX700AXJ8A","_score":null,"_source":{"set":3,"
num":3},"sort":[15]}]
--------------------
Done!
```

