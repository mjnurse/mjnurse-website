---
title: Oracle
---
# Using A Recursive Query To Determine Correct Order To Drop Tables

Also relevant for creating tables (but reverse the order).

```
SELECT     child_table
         , MAX(level) as lowest_depth
FROM (
   SELECT    child.table_name AS child_table
           , parent.table_name AS parent_table
   FROM      user_constraints child
   LEFT JOIN user_constraints parent
   ON      ( parent.r_constraint_name = child.constraint_name )
   )
CONNECT BY PRIOR child_table = parent_table
GROUP BY   child_table
ORDER BY   lowest_depth;

```
<hr>
