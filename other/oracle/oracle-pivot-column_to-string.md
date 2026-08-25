---
title: Oracle Pivot Column to String
---

```sql
SELECT
   dept_num
,  LISTAGG( emp_name, ',' ) WITHIN GROUP (ORDER BY emp_name) AS emps
FROM
   emp
GROUP BY
   dept_num
;
```
<hr>
