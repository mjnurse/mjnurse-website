---
title: Postgres and Jupyter
contents-list: h1,h2
---

## Initializing Postgres with Jupyter

To use Postgres with Jupyter notebooks, you can connect to a Postgres database from within a Jupyter notebook as follows:

Add the following code snippet to a Jupyter notebook:

```
%%capture
%pip install -U jupysql pgspecial "psycopg[binary,pool]"
%load_ext sql
%sql postgresql+psycopg://postgres:postgres@db:5432/postgres
%config SqlMagic.displaylimit = 200
```

- The `psycopg` library is used to connect to Postgres.
- The `jupysql` extension allows you to run SQL queries directly in your notebook cells.
- The `pgspecial` package adds some useful magic commands for working with Postgres - for example `\di+` to list indexes.
- `%%capture` is used to suppress the output of the pip install command.
- `%sql` magic command establishes a connection to the Postgres database running in a Docker container named `db`.

## Running SQL Queries

You can then run SQL queries directly in your notebook cells using the `%%sql` cell magic, or `%sql` for single-line queries. For example:

<div style="border:1px solid #222; border-radius:4px">
```sql
%%sql
SELECT * FROM test LIMIT 10;
```
</div>

## Using Postgres Magic Commands

To run a Postgres magic command, you can use the `%sql` prefix. For example:

<div style="border:1px solid #222; border-radius:4px">
```sql
%sql \di+
```
</div>

You cannot use `%%sql` for magic commands; they must be prefixed with `%sql`.

## Formatting Explain Plans

If you run an `EXPLAIN` command the output will be right-aligned and hard to read. You can format it using the following code snippet:

<div style="border:1px solid #222; border-radius:4px">
```
%%sql
result = %sql EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM test WHERE name = 'Alice Smith';
print("\n".join(row[0] for row in result))
```
</div>
