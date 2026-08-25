# Select From a List Of Static Values
#
# A short demo of the PostgreSQL select from a list of static values capability.

# ====================================================================================================
# TOPIC - Generating a set of values
# ====================================================================================================

# CODE 1.1
# ----------------------------------------------------------------------------------------------------

SELECT *
FROM ( VALUES (1), (2) ,(3), (4), (5) ) as v ( num )
;

SELECT *
FROM (VALUES (1, 'one'), (2, 'two'), (3, 'three')) AS t (num, letter)
;

# RESULTS - 1.1
# ----------------------------------------------------------------------------------------------------

num
-----
1
2
3
4
5

(5 rows)

num | letter
-----+--------
1 | one
2 | two
3 | three
(3 rows)
