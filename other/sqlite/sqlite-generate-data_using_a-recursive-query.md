---
title: sqlite Generate Data using a Recursive Query
---

A query to return 100 records.

```sql
WITH RECURSIVE
  rec(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM rec WHERE x<100)
SELECT x, ABS(RANDOM()) % 1000 FROM rec;
```

A more complex example using two record generators.

```sql
WITH RECURSIVE
  ent(e) AS (VALUES(1) UNION ALL SELECT e+1 FROM ent WHERE e<10),
  rec(r) AS (VALUES(1) UNION ALL SELECT r+1 FROM rec WHERE r<100)
SELECT  e, r
FROM    ent
JOIN    rec;
```

<hr>
