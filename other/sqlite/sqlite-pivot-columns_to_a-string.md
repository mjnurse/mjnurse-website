---
title: sqlite Pivot Columns to a String
---

An example of the sqlite GROUP_CONCAT function to pivot column values to a string.

```sql
.headers on
.mode columns

CREATE TABLE t (c1 INT, c2 INT);

INSERT INTO t VALUES (1, 'a');
INSERT INTO t VALUES (1, 'b');
INSERT INTO t VALUES (2, 'a');
INSERT INTO t VALUES (2, 'b');
INSERT INTO t VALUES (2, 'c');

SELECT    c1
        , GROUP_CONCAT(c2) AS str
FROM      t
GROUP BY  c1;

results
=======
c1          str
----------  ----------
1           a,b
2           a,b,c

```

Note: This is the same as the Oracle LISTAGG function.

<hr>
