\echo Total Tables
\echo

SELECT   COUNT(*)
FROM     t;

SELECT   database
      ,  COUNT(*) AS num_tables
      ,  SUM(CASE WHEN last_access_date = '' THEN 1 ELSE 0 END) AS last_used_null
      ,  SUM(CASE WHEN last_access_date = '' THEN 0 ELSE 1 END) AS last_used_not_null
      ,  SUM(CASE WHEN last_access_date > '20170711' THEN 1 ELSE 0 END) AS last_used_prev_12_months
      ,  SUM(CASE WHEN last_access_date > '20180611' THEN 1 ELSE 0 END) AS last_used_prev_1_month
      ,  SUM(CASE WHEN last_access_date > '20180704' THEN 1 ELSE 0 END) AS last_used_prev_1_week
FROM     t
GROUP BY database
ORDER BY 1;

/*
SELECT   database
      ,  SUM(CAST(space_utilised_kb AS FLOAT)) AS num_tables
      ,  SUM(CASE WHEN last_access_date = '' THEN CAST(space_utilised_kb AS FLOAT) ELSE 0 END) AS last_used_null
      ,  SUM(CASE WHEN last_access_date = '' THEN 0 ELSE CAST(space_utilised_kb AS FLOAT) END) AS last_used_not_null
      ,  SUM(CASE WHEN last_access_date > '20170711' THEN CAST(space_utilised_kb AS FLOAT) ELSE 0 END) AS last_used_prev_12_months
      ,  SUM(CASE WHEN last_access_date > '20180611' THEN CAST(space_utilised_kb AS FLOAT) ELSE 0 END) AS last_used_prev_1_month
      ,  SUM(CASE WHEN last_access_date > '20180704' THEN CAST(space_utilised_kb AS FLOAT) ELSE 0 END) AS last_used_prev_1_week
FROM     t
GROUP BY database
ORDER BY 1;
*/

\echo Database tables used within the last 12 months
\echo

DROP TABLE t2;
CREATE TABLE t2 AS
SELECT * FROM t
WHERE   last_access_date != ''; 

\echo Number of tables with the prefix or suffix - STG or in STG database
\echo

SELECT   COUNT(*)
FROM     t2
WHERE    database = 'EDW_SCVER_STG'
OR       UPPER(REGEXP_REPLACE(SUBSTR(table_name, 1, GREATEST(1, POSITION('_' IN table_name) - 1)), '\d', '', 'g')) = 'STG'
OR       UPPER(REGEXP_REPLACE(REVERSE(SUBSTR(REVERSE(table_name), 1, GREATEST(1, POSITION('_' IN REVERSE(table_name)) - 1))), '\d', '', 'g')) = 'STG';

\echo Non STG tables in main database (ignore woroking databases)
\echo

DROP TABLE t3;
CREATE TABLE t3 AS
SELECT   *
FROM     t2
WHERE    database != 'EDW_SCVER_STG'
AND      UPPER(REGEXP_REPLACE(SUBSTR(table_name, 1, GREATEST(1, POSITION('_' IN table_name) - 1)), '\d', '', 'g')) != 'STG'
AND      UPPER(REGEXP_REPLACE(REVERSE(SUBSTR(REVERSE(table_name), 1, GREATEST(1, POSITION('_' IN REVERSE(table_name)) - 1))), '\d', '', 'g')) != 'STG';

\echo
\echo Number of tables with the prefix or suffix - STG, TEMP, TMP, WRK, OLD, ETL, VOL
\echo

SELECT   l.str
      ,  COUNT(*)
FROM     (VALUES ('STG'), ('TEMP'), ('TMP'), ('WRK'), ('OLD'), ('ETL'), ('VOL')) AS l (str)
JOIN     t3 t
ON       ( 1 = 1 )
WHERE    t.database = 'EDW_SCVER'
AND      t.last_access_date != ''
AND      (  UPPER(REGEXP_REPLACE(SUBSTR(table_name, 1, GREATEST(1, POSITION('_' IN table_name) - 1)), '\d', '', 'g')) 
           = l.str
         OR UPPER(REGEXP_REPLACE(REVERSE(SUBSTR(REVERSE(table_name), 1, GREATEST(1, POSITION('_' IN REVERSE(table_name)) - 1))), '\d', '', 'g'))
           = l.str )
GROUP BY l.str
;

\echo Ignore tables with the prefix or suffix - STG, TEMP, TMP, WRK, OLD, ETL, VOL or in WORK db
\echo

DROP TABLE t4;

CREATE TABLE t4 AS
SELECT   *
FROM     t3
WHERE    database = 'EDW_SCVER'
AND      last_access_date != ''
AND      UPPER(REGEXP_REPLACE(SUBSTR(table_name, 1, GREATEST(1, POSITION('_' IN table_name) - 1)), '\d', '', 'g')) 
         NOT IN ('STG', 'TEMP', 'TMP', 'WRK', 'OLD', 'ETL', 'VOL')
AND      UPPER(REGEXP_REPLACE(REVERSE(SUBSTR(REVERSE(table_name), 1, GREATEST(1, POSITION('_' IN REVERSE(table_name)) - 1))), '\d', '', 'g'))
         NOT IN ('STG', 'TEMP', 'TMP', 'WRK', 'OLD', 'ETL', 'VOL')
;

SELECT   t1.table_name
      ,  t2.table_name
FROM     t4 t1
JOIN     t4 t2
ON       (1 = 1)
;

/*
SELECT   SUBSTR(table_name, 1, GREATEST(1, POSITION('_' IN table_name) - 1)) AS table_prefix
      ,  COUNT(*)
FROM     t2
GROUP BY SUBSTR(table_name, 1, GREATEST(1, POSITION('_' IN table_name) - 1))
HAVING   COUNT(*) >= 10
ORDER BY 2;

SELECT   REVERSE(SUBSTR(REVERSE(table_name), 1, GREATEST(1, POSITION('_' IN REVERSE(table_name)) - 1))) AS table_suffix
      ,  COUNT(*)
FROM     t2
GROUP BY REVERSE(SUBSTR(REVERSE(table_name), 1, GREATEST(1, POSITION('_' IN REVERSE(table_name)) - 1))) 
HAVING   COUNT(*) >= 10
ORDER BY 2;

*/
