# Recursive SQL Example
#
# Short demo of PostgreSQL recursive sql.

# ====================================================================================================
# TOPIC - Recursive query of a parent child hierarchy
# ====================================================================================================

# ====================================================================================================
# SECTION 1 - Here we find all decendents of the top level parents.
# ====================================================================================================

# CODE 1.1
# ----------------------------------------------------------------------------------------------------

# format run
DROP TABLE mjn_parent_child;
CREATE TABLE mjn_parent_child ( p VARCHAR, c VARCHAR );
INSERT INTO mjn_parent_child VALUES ( 'A', 'B' );
INSERT INTO mjn_parent_child VALUES ( 'A', 'C' );
INSERT INTO mjn_parent_child VALUES ( 'B', 'C' );
INSERT INTO mjn_parent_child VALUES ( 'C', 'D' );
INSERT INTO mjn_parent_child VALUES ( 'E', 'F' );
INSERT INTO mjn_parent_child VALUES ( 'D', 'H' );
INSERT INTO mjn_parent_child VALUES ( 'F', 'G' );

WITH RECURSIVE recur AS (
   SELECT p AS top_p
        , c
   FROM   mjn_parent_child
   UNION
   SELECT c.top_p
        , a.c
   FROM   mjn_parent_child a
   JOIN   recur c
   ON     ( a.p = c.c ) )
SELECT top_p
     , c
FROM   recur
WHERE  top_p NOT IN (
   SELECT c
   FROM   mjn_parent_child )
ORDER BY top_p
;

# RESULTS 1.1
# ----------------------------------------------------------------------------------------------------

# last run: 18/04/24 15:01:31

top_p | c
-------+---
A | B
A | C
A | D
A | H
E | F
E | G

(6 rows)


