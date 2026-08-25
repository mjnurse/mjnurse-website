SELECT   COUNT(DISTINCT file)
FROM     s
WHERE    filetype = 'sql';

DROP TABLE s2;
CREATE TABLE s2 AS
SELECT   DISTINCT
         file
      ,  filetype
FROM 
(  SELECT   file
         ,  CASE WHEN file LIKE '%_run.sql' THEN 'run'
                 WHEN SUBSTRING(file, '.*\d\d\d\d201[678].*') != '' 
                   OR SUBSTRING(file, '.*201[678]\d\d\d\d.*') != '' THEN 'contains date'
                 WHEN file LIKE  '%bkp%' THEN 'bkp'
                 WHEN filetype IN ('sql','csv','txt') THEN filetype 
                 WHEN filetype IN ('sh','ksh') THEN 'sh'
            ELSE 'other' END AS filetype
   FROM     s
   WHERE    filetype = 'sql' ) t
;

SELECT   filetype
      ,  COUNT(*) AS num
FROM     s2
GROUP BY filetype
ORDER BY 2
;

SELECT   COUNT(DISTINCT file) 
FROM     s
WHERE    filetype != 'sql';

DROP TABLE s3;
CREATE TABLE s3 AS
SELECT   DISTINCT
         file
      ,  filetype
FROM 
(  SELECT   file
         ,  CASE WHEN file LIKE '%_run.sql' THEN 'run'
                 WHEN SUBSTRING(file, '.*\d\d\d\d201[678].*') != '' 
                   OR SUBSTRING(file, '.*201[678]\d\d\d\d.*') != '' THEN 'contains date'
                 WHEN file LIKE  '%bkp%' THEN 'bkp'
                 WHEN filetype IN ('sql','csv','txt') THEN filetype 
                 WHEN filetype IN ('sh','ksh') THEN 'sh'
            ELSE 'other' END AS filetype
   FROM     s
   WHERE    filetype != 'sql' ) t
;

SELECT   filetype
      ,  COUNT(*) AS num
FROM     s3
GROUP BY filetype
ORDER BY 2
;


/*
SELECT   solution
      ,  SUM( CASE WHEN filetype = 'sh' THEN 1 ELSE 0 END ) AS sh
      ,  SUM( CASE WHEN filetype = 'sql' THEN 1 ELSE 0 END ) AS sql
FROM 
(  SELECT   CASE WHEN file LIKE '%poise%' THEN 'poise'
                 WHEN file LIKE '%mears%' THEN 'mears'
                 WHEN file LIKE '%fleet%' THEN 'fleet'
                 WHEN file LIKE '%kognitio%' THEN 'kognitio'
                 WHEN file LIKE '%credo%' THEN 'credo'
                 WHEN file LIKE '%traffic%' THEN 'traffic'
                 WHEN file LIKE '%mars%' THEN 'mars'
                 WHEN file LIKE '%rmgtt%' THEN 'rmgtt'
                 WHEN file LIKE '%fleet%' THEN 'fleet'
                 ELSE '000 - '||file
            END AS solution
         ,  filetype
   FROM     s3 ) t
GROUP BY solution
ORDER BY 1;

SELECT   token
      ,  COUNT(*) AS num
FROM
   (  SELECT s.token
      FROM   s3 t, unnest(string_to_array(REPLACE(t.file, '.', '_'), '_')) s(token) ) t
GROUP BY token
ORDER BY 2, 1
;
*/


/*
SELECT   b.file
      ,  a.file 
FROM     s2 a 
JOIN     s2 b 
ON       (  a.file != b.file 
         AND a.filetype = b.filetype
         AND a.file NOT LIKE '%_run.sql' 
         AND REPLACE(a.file, '.sql','') LIKE REPLACE(b.file, '.sql','')||'%')
WHERE    a.filetype IN ('sh','sql')
;*/
