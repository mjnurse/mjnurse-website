---
title: Postgres
contents-list: h1,h2
---

## Generating Data

Generate 10 random timestamps within the last 5 years.

```sql
SELECT i, NOW() - (RANDOM() * INTERVAL '5 years') 
FROM   generate_series(1, 10) AS gs(i); -- alias as gs, alias column as i.
```

## Selecting 'n' Random Rows From a Table

Select 10 random rows from the 'tmp' table. The query uses a CROSS JOIN LATERAL to select a random row for each iteration of the generate_series, ensuring that the random selection is performed for each row generated.

```sql
-- Create a temporary table and insert some data.
CREATE TEMP TABLE tmp (id INT, txt TEXT);
INSERT INTO tmp (id, txt) VALUES (1, 'foo'), (2, 'bar'), (3, 'baz');

-- Select 10 random rows from the 'tmp' table.
SELECT i, t.*
FROM   generate_series(1, 10) AS gs(i) -- alias as gs, alias column as i.
CROSS JOIN LATERAL (
    SELECT   *
    FROM     tmp
    -- Order by referencing 'i' is required to ensure Postgres does not optimize the query
    -- and runs the CROSS JOIN LATERAL rather than switching to a simple join.
    ORDER BY i, random()
    LIMIT 1
) AS t;
```

### Transposing Column Values into Rows

```sql
-- Create a temporary table with an 'items' column containing comma-separated values.
CREATE TEMP TABLE tmp AS
SELECT id, RANDOM(1,10)||','||RANDOM(1,10)||','||RANDOM(1,10) AS items
FROM   generate_series(1, 3) AS gs(id);

SELECT * FROM tmp;

 id | items
----+-------
  1 | 1,2,6
  2 | 5,7,4
  3 | 2,1,7
(3 rows)

-- Use CROSS JOIN LATERAL with UNNEST to transpose the 'items' column into rows (id, item).
SELECT id, item
FROM   tmp t
CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(t.items, ',')) AS u(item);

 id | item
----+------
  1 | 1
  1 | 2
  1 | 6
  2 | 5
  2 | 7
  2 | 4
  3 | 2
  3 | 1
  3 | 7
(9 rows)
```
