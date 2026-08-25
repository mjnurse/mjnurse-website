---
title: Improve Elasticsearch Performance
contents-list: h1,h2
---
# Overview

Some tips on how to improve / ensure good Elasticsearch performance.

# Customize Field Mappings

If you don't need to search a field, don't index it:

```json
{
    "field_name": {
        "type":     "string",
        "index":    "no"
    }
}
```

For fields you want to index, use the simplest analyzer, or maybe don't analyze at all.  By default, `string` fields are `analyzed` as are the strings in any queries on this fields.  The other option is `not_analyzed` - the field is indexed so it is searchable, but the value is indexed, as a single string, exactly as specified.


```json
{
    "field_name": {
        "type":     "string",
        "index":    "not_analyzed"
    }
}
```

The other simple types (long, double, date, etc.) also accept the index parameter, but the only relevant values are `no` and `not_analyzed` because their values are never `analyzed`.

Alternately specify `analyzer`: For analyzed string fields specify which analyzer to apply both at search time and index time. By default, Elasticsearch uses the `standard` analyzer, but you can change this by specifying one of the built-in analyzers, such as `whitespace`, `simple`, or `english`.

```json
{
    "tweet": {
        "type":     "string",
        "analyzer": "english"
    }
}
```

# Disable The _source Field

`_source` contains the original JSON document alongside the indexed fields.  This can be removed when creating the index:

```bash
PUT index_name -d '
{
    "mappings": {
        "_source": {
            "enabled": false
        }
    }
}
```

However, without `_source` we cannot:

- View the source field (string) which matched a query, we can only identify the doc `_id` for the match.

- Do on the fly highlighting.

- Use the `update`, `update_by_query` and `reindex` APIs.

- Upgrade an index to a new major version or repair index corruption automatically.

An expert-only feature is the ability to prune the contents of the `_source` field after the document has been indexed, but before the `_source` field is stored. Removing fields from the `_source` has similar downsides to disabling `_source`.

# Disable the _all Field

<hr>
