---
title: 25-05-08 - Python Print JSON as a Table
---

I often want to look at an array/set of JSON objects in a tabular format.  I wrote the following.  Posting here as I'll want it again...

```python
def jsontable(jsn, keys=[]):
    # Get all the keys (columns)
    columns = [key for key in jsn[0].keys() if key in keys or keys == []] if jsn else []

    # Determine max width for each column, including the column name and the longest value in that column
    column_widths = {col: max(len(col), max(len(str(row.get(col, ''))) for row in jsn)) for col in columns}

    # Print the header
    header = " | ".join(f"{col:<{column_widths[col]}}" for col in columns)
    print(header)
    print("-" * (len(header)))

    # Print each row
    for row in jsn:
        print(" | ".join(f"{str(row.get(col, '')):<{column_widths[col]}}" for col in columns))
```

