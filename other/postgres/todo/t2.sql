SELECT   *
FROM     t2
WHERE    UPPER(table_name) LIKE UPPER('&1');
