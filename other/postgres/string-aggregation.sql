# Aggregating a Group of String Field Values in to a String
#
# A short demo of the PostgreSQL string aggregation function.

# ====================================================================================================
# TOPIC - Aggregate string for rows into single column
# ====================================================================================================

# ====================================================================================================
# SECTION 1 - Example
# ====================================================================================================

# CODE 1.1
# ----------------------------------------------------------------------------------------------------
# noformat run

DROP TABLE mjn_agg_strings;

CREATE TABLE mjn_agg_strings
( id int
, str VARCHAR );

INSERT INTO mjn_agg_strings VALUES ( 1, 'dog' );
INSERT INTO mjn_agg_strings VALUES ( 1, 'cat' );
INSERT INTO mjn_agg_strings VALUES ( 1, 'cow' );
INSERT INTO mjn_agg_strings VALUES ( 2, 'red' );
INSERT INTO mjn_agg_strings VALUES ( 2, 'blu' );

SELECT   id
      ,  STRING_AGG( str, '|' )
FROM     mjn_agg_strings
GROUP BY id;

# RESULTS - 1.1
# ----------------------------------------------------------------------------------------------------
# last run: 18/04/26 12:05:39

id | string_agg
----+-------------
1 | dog|cat|cow
2 | red|blu
(2 rows)
