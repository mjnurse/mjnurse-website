---
title: SQL Cheat Sheet
contents-list: h1,h2
---

# SQL Basics

```sql
-- Selecting Data
SELECT column_name FROM table_name;

-- Selecting Data with Conditions
SELECT column_name FROM table_name WHERE column_name = 'value';

-- Sorting Data
SELECT column_name FROM table_name ORDER BY column_name ASC;
SELECT column_name FROM table_name ORDER BY column_name DESC;

-- Limiting Results
SELECT column_name FROM table_name LIMIT 100; -- 100 rows

-- Joining Tables
SELECT column_name FROM table1 JOIN table2 ON table1.column_name=table2.column_name;

-- Grouping Data
SELECT column_name column_name2 FROM table_name GROUP BY column_name;

-- Filtering Groups
SELECT column_name, SUM(column_name2) 
FROM table_name 
GROUP BY column_name 
HAVING SUM(column_name2) > 100;
```

# SQL Functions

## Aggregate Functions

```sql
SELECT COUNT(column_name) FROM table_name;

SELECT SUM(column_name) FROM table_name;

SELECT AVG(column_name) FROM table_name;

SELECT MAX(column_name) FROM table_name;

SELECT MIN(column_name) FROM table_name;
```

## String Functions

```sql
SELECT CONCAT(column1, column2) FROM table_name;

SELECT SUBSTRING(column_name, start_position, length) FROM table_name;

SELECT UPPER(column_name) FROM table_name;

SELECT LOWER(column_name) FROM table_name;

SELECT LENGTH(column_name) FROM table_name;
```

## Date Functions

```sql
SELECT YEAR(column_name) FROM table_name;

SELECT MONTH(column_name) FROM table_name;

SELECT DAY(column_name) FROM table_name;

SELECT HOUR(column_name) FROM table_name;

SELECT MINUTE(column_name) FROM table_name;

SELECT SECOND(column_name) FROM table_name;
```

## Conditional Functions

```sql
SELECT column_name, CASE WHEN condition THEN 'Result1' ELSE 'Result2' END FROM table_name;
```

## SQL Data Types

Numeric Data Types

`INT, FLOAT, DOUBLE, DECIMAL`

Date and Time Data Types

`DATE, TIME, DATETIME, TIMESTAMP`

Character and String Data Types

`CHAR, VARCHAR, TEXT`

Miscellaneous Data Types

`BOOLEAN, BLOB, ENUM, SET`

# Other SQL

## SQL Constraints

```sql
-- NOT NULL Constraint
CREATE TABLE table_name (
  column1 datatype NOT NULL,
  column2 datatype,
  column3 datatype,
  ...
);

-- UNIQUE Constraint
CREATE TABLE table_name (
  column1 datatype UNIQUE,
  column2 datatype,
  column3 datatype,
  ...
);

-- PRIMARY KEY Constraint
CREATE TABLE table_name (
  column1 datatype,
  column2 datatype,
  column3 datatype,
  ...
  CONSTRAINT pk_column1 PRIMARY KEY (column1, column2)
);

-- FOREIGN KEY Constraint
CREATE TABLE table_name1 (
  column1 datatype PRIMARY KEY,
  column2 datatype,
  column3 datatype,
  ...
);
CREATE TABLE table_name2 (
  column1 datatype,
  column2 datatype,
  column3 datatype,
  ...
  CONSTRAINT fk_column1 FOREIGN KEY (column1) REFERENCES table_name1(column1)
);

-- CHECK Constraint
CREATE TABLE table_name (
  column1 datatype,
  column2 datatype CHECK (column2 > 0),
  column3 datatype,
  ...
);
```

## SQL Indexes

```sql
-- Creating Index
CREATE INDEX index_name ON table_name (column1, column2, ...);

-- Removing Index
DROP INDEX index_name;
```

## SQL Views

```sql
-- Creating View
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- Updating View
CREATE OR REPLACE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- Dropping View
DROP VIEW view_name;
```

## SQL Joins

```sql
-- Inner Join
SELECT column_name
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;

-- Left Join
SELECT column_name
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;

-- Right Join
SELECT column_name
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;

-- Full Join
SELECT column_name
FROM table1
FULL JOIN table2
ON table1.column_name = table2.column_name;
```

## SQL Subqueries

```sql
-- Using a Subquery in a WHERE Clause
SELECT column1, column2, ...
FROM table_name
WHERE column_name IN (SELECT column_name FROM table_name WHERE condition);

-- Using a Subquery in a FROM Clause
SELECT column1, column2, ...
FROM (SELECT column_name FROM table_name WHERE condition) AS subquery_name;
Using a Subquery in a SELECT Clause
SELECT column1, column2, ..., (SELECT column_name FROM table_name WHERE condition) AS column_alias
FROM table_name;

-- SQL Union
Combining Results from Multiple Queries
SELECT column1, column2, ... FROM table_name1
UNION
SELECT column1, column2, ... FROM table_name2;

-- Combining Results and Removing Duplicates
SELECT column1, column2, ... FROM table_name1
UNION DISTINCT
SELECT column1, column2, ... FROM table_name2;
```

## SQL Transactions

```sql
-- Starting a Transaction
START TRANSACTION;

-- Committing a Transaction
COMMIT;

-- Rolling Back a Transaction
ROLLBACK;
```

## SQL Stored Procedures

```sql
-- Creating a Stored Procedure
CREATE PROCEDURE procedure_name
AS
BEGIN
  SQL statements
END;

-- Executing a Stored Procedure
EXEC procedure_name;
Altering a Stored Procedure
ALTER PROCEDURE procedure_name
AS
BEGIN
  SQL statements
END;
```

## SQL Triggers

```sql
-- Creating a Trigger
CREATE TRIGGER trigger_name
AFTER INSERT, UPDATE, DELETE ON table_name
FOR EACH ROW
BEGIN
  SQL statements
END;

-- Altering a Trigger
ALTER TRIGGER trigger_name
AFTER INSERT, UPDATE, DELETE ON table_name
FOR EACH ROW
BEGIN
  SQL statements
END;

-- Dropping a Trigger
DROP TRIGGER trigger_name;
```
