SELECT   *
FROM     t
WHERE    UPPER(table_name) LIKE UPPER('&1');
