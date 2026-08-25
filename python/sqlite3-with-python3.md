---
title: Sqlite3 With Python3
contents-list: h1,h2
---

An example of how to use a Sqlite3 database with Python3.

```python
import sqlite3

def dbOpen(name):
  return sqlite3.connect(name)

def dbRunSQL(conn, sql, values = ()):
  try:
    cur = conn.cursor()
    cur.execute(sql, values)
    rows = cur.fetchall()
    conn.commit()
    return rows
  except Exception as e:
    print('Error:', e)

def test():
  conn = dbOpen('test.db')
  dbRunSQL(conn, 'DROP TABLE test')
  dbRunSQL(conn, 'CREATE TABLE test(n NUMBER, t TEXT)')

  dbRunSQL(conn, 'INSERT INTO test(n, t) VALUES (?, ?)', (1, 'Hello'))
  dbRunSQL(conn, 'INSERT INTO test(n, t) VALUES (?, ?)', (2, 'Goodbye'))
  print(dbRunSQL(conn, 'SELECT * FROM test'))

  dbRunSQL(conn, 'UPDATE test SET t = ? WHERE n = ?', ('See ya', 2))
  print(dbRunSQL(conn, 'SELECT * FROM test'))

  dbRunSQL(conn, 'DELETE FROM test WHERE n = ?', (1,))
  print(dbRunSQL(conn, 'SELECT * FROM test'))

if __name__ == '__main__':
  test()
```

<hr>
