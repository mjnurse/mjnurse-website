---
title: Oracle Window Function
---

```sql
CREATE TABLE mjn (g NUMBER, n NUMBER, v VARCHAR2(8));

INSERT INTO mjn VALUES (1, 1, 'a');
INSERT INTO mjn VALUES (1, 2, 'b');
INSERT INTO mjn VALUES (1, 6, 'c');
INSERT INTO mjn VALUES (1, 7, 'd');
INSERT INTO mjn VALUES (1, 9, 'e');
INSERT INTO mjn VALUES (2, 3, 'a');
INSERT INTO mjn VALUES (2, 4, 'b');
INSERT INTO mjn VALUES (2, 8, 'c');
INSERT INTO mjn VALUES (2, 8, 'd');

SELECT N
     , LAG(N,1,NULL) OVER (PARTITION BY g ORDER BY N) prev_n
     , LEAD(N,1,NULL) OVER (PARTITION BY G ORDER BY N) next_n
     , FIRST_VALUE(N) OVER (PARTITION BY G ORDER BY N) first_n
     , LAST_VALUE(N) OVER (PARTITION BY G ORDER BY N) last_n
     , LAST_VALUE(N) OVER (PARTITION BY G ORDER BY N ROWS BETWEEN 
          UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) last_n_unbounded
     , V
     , LAG(V,1,NULL) OVER (PARTITION BY g ORDER BY N) prev_v 
FROM mjn;

         N     PREV_N     NEXT_N    FIRST_N     LAST_N LAST_N_UNBOUNDED V        PREV_V  
---------- ---------- ---------- ---------- ---------- ---------------- -------- --------
         1                     2          1          1                9 a                
         2          1          6          1          2                9 b        a       
         6          2          7          1          6                9 c        b       
         7          6          9          1          7                9 d        c       
         9          7                     1          9                9 e        d       
         3                     4          3          3                8 a                
         4          3          8          3          4                8 b        a       
         8          4          8          3          8                8 c        b       
         8          8                     3          8                8 d        c       
```
<hr>
