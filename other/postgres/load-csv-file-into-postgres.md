---
title: Load CSV File Into Postgres
---

### Create your table

```
CREATE TABLE zip_codes 
( zip CHAR(5)
, latitude DOUBLE PRECISION
, longitude DOUBLE PRECISION
, city VARCHAR
, state CHAR(2)
, county VARCHAR
, zip_class VARCHAR );
```

### Copy data from your CSV file to the table:

```
\copy zip_codes FROM '/path/to/csv/ZIP_CODES.txt' DELIMITER ',' CSV
```

### You can also specify the columns to read:

```
\copy zip_codes(ZIP,CITY,STATE) FROM '/path/to/csv/ZIP_CODES.txt' DELIMITER ',' CSV
```
<hr>
