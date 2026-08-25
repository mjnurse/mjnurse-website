@echo off

SET server=localhost
SET database=postgres
SET port=5432
SET username=postgres
SET PGPASSWORD=postgres

"C:\Program Files\PostgreSQL\11\bin\psql.exe" -h %server% -U %username% -d %database% -p %port% -P pager=off -f %1
