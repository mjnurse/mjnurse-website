---
title: Recursive Query to Navigate a Tree
---

An example of a recursive query to navigate a tree.  For the tree I chose a small part of the Royal Family Tree.

### Step 1 - Create the parent child records in a table:

```sql
CREATE TABLE family(child, parent);

INSERT INTO family VALUES ('ElizabethI', '');
INSERT INTO family VALUES ('ElizabethII', 'ElizabethI');
INSERT INTO family VALUES ('Charles', 'ElizabethII');
INSERT INTO family VALUES ('Anne', 'ElizabethII');
INSERT INTO family VALUES ('Andrew', 'ElizabethII');
INSERT INTO family VALUES ('Edward', 'ElizabethII');
INSERT INTO family VALUES ('William', 'Charles');
INSERT INTO family VALUES ('Harry', 'Charles');
INSERT INTO family VALUES ('George', 'William');
INSERT INTO family VALUES ('Charlotte', 'William');
INSERT INTO family VALUES ('Louis', 'William');
INSERT INTO family VALUES ('Archie', 'Harry');
```

### Step 2: The recursive query:

```sql
.mode column
.width 5 40
WITH RECURSIVE rec(person, depth, padding, path) AS (
  SELECT  child
        , 1
        , ''
        , ''
  FROM    family
  WHERE parent = ''
  UNION ALL
  SELECT  family.child
        , depth + 1
        , padding||'   ' -- for indenting children
        , path||child    -- to order the results
  FROM    family
  JOIN    rec
  ON      (family.parent = rec.person)
)
SELECT    depth
        , padding||person
FROM      rec
ORDER BY  path;
```

The output when running the query:

```bash
$> cat recursive.sql | sqlite3

1      ElizabethI
2         ElizabethII
3            Andrew
3            Anne
3            Charles
4               Harry
5                  Archie
4               William
5                  Charlotte
5                  George
5                  Louis
3            Edward
```



<hr>
