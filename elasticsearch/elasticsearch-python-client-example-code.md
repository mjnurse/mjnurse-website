---
title: Elasticsearch Python Client Example Code
---

```python
from elasticsearch import Elasticsearch
import warnings
from elasticsearch.exceptions import ElasticsearchWarning

# Disable the elasticsearch security warnings.
warnings.simplefilter('ignore', ElasticsearchWarning)

es = Elasticsearch('http://localhost:9200')

# Create index.
es.indices.create(index="test-index")

# Insert records.
for i in range(1,5):
    # Note: id parameter optional.
    resp = es.index(index="test-index", id=i, document={"a":1, "b": i})
    print("Responce:", resp)

# Get record by id.
resp = es.get(index="test-index", id=1)
print("Responce:", resp)

# refresh index.
resp = es.indices.refresh(index="test-index")
print("Responce:", resp)

# Search index.
resp = es.search(index="test-index", query={"match": {"b": 2}})
print("Got %d Hits:" % resp['hits']['total']['value'])
for hit in resp['hits']['hits']:
    print("Hit:", hit)

# Delete record.
resp = es.delete(index="test-index", id=1)
print("Responce:", resp)

# Delete index.
resp = es.indices.delete(index="test-index")
print("Responce:", resp)
```

