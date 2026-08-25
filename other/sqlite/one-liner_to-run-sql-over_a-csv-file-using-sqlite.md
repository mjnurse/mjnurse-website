---
title: One Liner to Run SQL Over a CSV File Using Sqlite
section: sqlite
---

Assume we have a cvs file `people.csv`:

```bash
> cat people.csv
name,sex,age
martin,m,21
paul,m,50
dave,m,58
sarah,f,33
anna,f,53
```

We can run a SQL command on this file using a single line (Linux) `sqlite3` command:

```bash
> sqlite3 :memory: \                             # Use an in memory database
         -cmd '.mode csv' \                      # Switch to csv mode for import
         -cmd '.import <filename> <tablename>' \ # Import file as csv
         -cmd '.mode column'                     # Switch to column mode for output
         -header \                               # Show header for output
         '<sql_statement>'
```

An example over `people.csv`:

```bash
> sqlite3 :memory: -cmd '.mode csv' -cmd '.import people.csv people' \
          -cmd '.mode column' -header \
          'SELECT sex, COUNT(*), AVG(age) FROM people GROUP BY sex'

sex         COUNT(*)    AVG(age)
----------  ----------  ----------
f           2           43.0
m           3           43.0
```

---

How well does it perform?  Let's run over 500,000 records:

```bash
# Create a 500,000 record file.  Take 5 rows (no header) from people.csv and write it
# 100 times to people2.csv

> for ((i=0; i<100; i++)); do tail -5 people.csv >> people2.csv; done

# Write people2.csv 1000 times into people3.csv

> for ((i=0; i<1000; i++)); do cat people2.csv >> people3.csv; done

# Add the header and 500,000 lines to people4.csv

> head -1 people.csv > people4.csv; cat people3.csv >> people4.csv

# Check we have 500,000 records and 1 line header

> wc -l people4.csv
500001 people4.csv

# Run the SQL query over people4.csv

> time sqlite3 :memory: -cmd '.mode csv' -cmd '.import people4.csv people' \
       -cmd '.mode column' -header \
       'SELECT sex, COUNT(*), AVG(age) FROM people GROUP BY sex'

sex         COUNT(*)    AVG(age)
----------  ----------  ----------
f           200000      43.0
m           300000      43.0

real    0m0.924s
user    0m0.641s
sys     0m0.188s
```

Roughly 1 second.  Not bad.


