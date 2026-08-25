@ECHO off
DEL load.cmds
FOR /R %1 %%f in (*) do echo SELECT '%%~nxf'; >> load.cmds & echo TRUNCATE TABLE file; >> load.cmds & echo \COPY file FROM '%%f' >> load.cmds & echo INSERT INTO files SELECT '%%~nxf', text FROM file; >> load.cmds 

set PGPASSWORD=postgres
SET server=localhost
SET database=postgres
SET port=5432
SET username=postgres

"C:\Program Files\PostgreSQL\10\bin\psql.exe" -h %server% -U %username% -d %database% -p %port% -P pager=off -f load.cmds

