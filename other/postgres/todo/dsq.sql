SELECT   *
FROM     ds1
WHERE    job_name LIKE '%&1%'
OR       project_name LIKE '%&1%';
