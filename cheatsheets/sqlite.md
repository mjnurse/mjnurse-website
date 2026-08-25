---
title: SQLite
contents-list: h1,h2
---

# Syntax Diagrams

[Syntax Diagrams](https://sqlite.org/syntaxdiagrams.html)

# Session Settings

| Setting                  | Description |
|--------------------------|-------------|
| `.changes on`            | |
| `.headers on`            | |
| `.mode column`           | |
| `.timer on`              | Outputs run time each statement. |
| `.trace stdout`          | Outputs each statement (can be to a file) |
| `.width [n] [n] ... [n]` | Column widths |

# Datatypes

| Datatype | Description |
|----|----|
| NULL | The value is a NULL value. |
| INTEGER | The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value. |
| REAL | The value is a floating point value, stored as an 8-byte IEEE floating point number. |
| TEXT | The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE). |
| BLOB | The value is a blob of data, stored exactly as it was input.xxx |

# Comments

```sql
-- One line comment
/*
Mutliple line comment
*/
```

# Functions / Expressions

| Function | Description |
|----------|-------------|
| `abs(X)` | Returns the absolute value of the numeric argument X |
| `changes()` | Returns the number of database rows that were changed or inserted or deleted by the most recently completed statement. |
| `char(X1,X2,...,XN)` | Returns a string composed of characters having the unicode code point values of integers X1 through XN, respectively. |
| `coalesce(X,Y,...)` | Returns a copy of its first non-NULL argument, or NULL if all arguments are NULL. |
| `glob(X,Y)` | Equivalent to the expression "Y GLOB X". |
| `hex(X)` | Interprets its argument as a BLOB and returns a string which is the upper-case hexadecimal rendering of the content of that blob. |
| `ifnull(X,Y)` | Returns a copy of its first non-NULL argument, or NULL if both arguments are NULL. |
| `iif(X,Y,Z)` | Returns the value Y if X is true, and Z otherwise. |
| `instr(X,Y)` | Finds the first occurrence of string Y within string X and returns the number of prior characters plus 1, or 0 if Y is nowhere found within X. |
| `last_insert_rowid()` | Returns the ROWID of the last row insert from the database connection which invoked the function. |
| `length(X)` | For a string value X, the length(X) function returns the number of characters (not bytes) in X prior to the first NUL character. |
| `like(X,Y) like(X,Y,Z)` | Implements the "Y LIKE X [ESCAPE Z]" expression. |
| `lower(X)` | To lowercase. |
| `ltrim(X) ltrim(X,Y)` | Returns a string formed by removing any and all characters that appear in Y from the left side of X. If the Y argument is omitted, ltrim(X) removes spaces from the left side of X. |
| `max(X,Y,...)` | Returns the argument with the maximum value, or return NULL if any argument is NULL. |
| `min(X,Y,...)` | Returns the argument with the minimum value. |
| `nullif(X,Y)` | Returns its first argument if the arguments are different and NULL if the arguments are the same. |
| `printf(FORMAT,...)` | The first argument is a format string that specifies how to construct the output string using values taken from subsequent arguments. |
| `quote(X)` | Returns the text of an SQL literal which is the value of its argument suitable for inclusion into an SQL statement. |
| `random()` | Returns a pseudo-random integer between -9223372036854775808 and +9223372036854775807.
| `randomblob(N)` | The randomblob(N) function return an N-byte blob containing pseudo-random bytes. If N is less than 1 then a 1-byte random blob is returned.  Hint: applications can generate globally unique identifiers using this function together with hex() and/or lower() like this: lower(hex(randomblob(16))) |
| `replace(X,Y,Z)` | Returns a string formed by substituting string Z for every occurrence of string Y in string X. |
| `round(X) round(X,Y)` | Returns a floating-point value X rounded to Y digits to the right of the decimal point. If the Y argument is omitted, it is assumed to be 0. |
| `rtrim(X) rtrim(X,Y)` | Returns a string formed by removing any and all characters that appear in Y from the right side of X. If the Y argument is omitted, rtrim(X) removes spaces from the right side of X. |
| `soundex(X)` | Returns a string that is the soundex encoding of the string X. |
| `substr(X,Y,Z) substr(X,Y)` | Returns a substring of input string X that begins with the Y-th character and which is Z characters long. If Z is omitted then substr(X,Y) returns all characters through the end of the string X beginning with the Y-th. |
| `total_changes()` | Returns the number of row changes caused by INSERT, UPDATE or DELETE statements since the current database connection was opened. |
| `trim(X) trim(X,Y)` | Returns a string formed by removing any and all characters that appear in Y from both ends of X. If the Y argument is omitted, trim(X) removes spaces from both ends of X. |
| `typeof(X)` | Returns a string that indicates the datatype of the expression X: "null", "integer", "real", "text", or "blob". |
| `unicode(X)` | Returns the numeric unicode code point corresponding to the first character of the string X. |
| `upper(X)` | Uppercase. |
| `zeroblob(N)` | Returns a BLOB consisting of N bytes of 0x00. |

# Operators

SQLite understands the following binary operators, in order from highest to lowest precedence:

```sql
||
*    /    %
+    -
<<   >>   &    |
<    <=   >    >=
=    ==   !=   <>   IS   IS NOT   IN   LIKE   GLOB   MATCH   REGEXP
AND   
OR
```

Supported unary prefix operators are these:

```sql
-    +    ~    NOT
```

The COLLATE operator is a unary postfix operator that assigns a collating sequence to an expression.

The `IS` and `IS NOT` operators work like `=` and `!=` except `NULL IS NULL` is true and `1 IS NOT NULL` is true.

# Literal Values (Constants)

A literal value represents a constant. Literal values may be integers, floating point numbers, strings, BLOBs, or NULLs.

| Literal | Description |
|---------|-------------|
| numeric | If a numeric literal has a decimal point or an exponentiation clause or if its magnitude is less than -9223372036854775808 or greater than 9223372036854775807, then it is a floating point literal. Otherwise is it is an integer literal. |
| hexadecimal | Follow the C-language notation of "0x" or "0X" followed by hexadecimal digits. For example, 0x1234 |
| string | 'example' 'don''t'
| BLOB | Strings containing hexadecimal data and preceded by a single "x" or "X" character. Example: X'53514C697465' |

A literal value can also be the token "NULL".

# Parameters

A "variable" or "parameter" token specifies a placeholder in the expression for a value that is filled in at runtime.

| Variable | Description |
|----------|-------------|
| `?NNN` | A question mark followed by a number `NNN` holds a spot for the NNN-th parameter. |
| `?` | A question mark that is not followed by a number creates a parameter with a number one greater than the largest parameter number already assigned. |
| `:AAAA` | A colon followed by an identifier name holds a spot for a named parameter with the name `:AAAA`. Named parameters are also numbered. The number assigned is one greater than the largest parameter number already assigned. |
| `@AAAA` | An "at" sign works exactly like a colon, except that the name of the parameter created is `@AAAA`.
| `$AAAA` | A dollar-sign followed by an identifier name also holds a spot for a named parameter with the name `$AAAA`. The identifier name in this case can include one or more occurrences of "::" and a suffix enclosed in "(...)" containing any text at all. |

Parameters that are not assigned values are treated as NULL.

# LIKE, GLOB, REGEXP and BETWEEN 

| Operator | Description |
|----------|-------------|
| `LIKE` | `string LIKE pattern`.  A percent symbol `%` matches any sequence of zero or more characters in the string. An underscore `_` matches any single character in the string. LIKE is not case sensitive. |
| `GLOB` | Similar to LIKE but uses the Unix file globbing syntax for its wildcards. Also, GLOB is case sensitive, unlike LIKE. |
| `REGEXP` | `X REGEXP Y` operator will be implemented as a call to the user function "regexp(Y,X)". |
| `BETWEEN` | `x BETWEEN y AND z` is logically `x>=y AND x<=z` |

# CASE 

```sql
CASE x WHEN w1 THEN r1 WHEN w2 THEN r2 ELSE r3 END
CASE WHEN x=w1 THEN r1 WHEN x=w2 THEN r2 ELSE r3 END
```

A NULL result is considered untrue when evaluating WHEN terms.

If the base expression is NULL then the result of the CASE is always the result of evaluating the ELSE expression if it exists, or NULL if it does not.

Both forms of the CASE expression use lazy, or short-circuit, evaluation.

# IN and NOT IN 

```sql
SELECT v FROM t WHERE v IN (1, 4, 9);
SELECT v FROM t WHERE v IN (SELECT y FROM z);
```
# ROWID

`ROWID`, `OID`, or `_ROWID_`

The three special identifiers describe the unique integer key (the rowid) associated with every row of every table.

# EXISTS 

```sql
SELECT v FROM t WHERE EXISTS (SELECT a FROM b WHERE y = z);
```

# CAST expressions

`CAST(expr AS datatype-name)`

If the value of expr is NULL, then the result of the CAST expression is also NULL.

# Boolean Expressions

Beginning with SQLite 3.23.0 (2018-04-02), SQLite recognizes the identifiers "TRUE" and "FALSE" as boolean literals, if and only if those identifiers are not already used for some other meaning. 

The boolean identifiers TRUE and FALSE are usually just aliases for the integer values 1 and 0, respectively. 

# Date / Time

SQLite supports five date and time functions as follows:

- `date(timestring, modifier, modifier, ...)`

- `time(timestring, modifier, modifier, ...)`

- `datetime(timestring, modifier, modifier, ...)`

- `julianday(timestring, modifier, modifier, ...)`

- `strftime(format, timestring, modifier, modifier, ...)`

All five date and time functions take a time string as an argument. The time string is followed by zero or more modifiers. The strftime() function also takes a format string as its first argument.

| Function | Description |
|----------|-------------|
| `date()` | Returns the date in this format: YYYY-MM-DD. |
| `time()` | Returns the time as HH:MM:SS. |
| `datetime()` | Returns "YYYY-MM-DD HH:MM:SS". |
| `julianday()` | Returns the Julian day - the number of days since November 24, 4714 B.C. |
| `strftime()` | Returns the date formatted according to the format string specified as the first argument. |

## Date Format String

| String | Description |
|--------|-------------|
| `%d` | day of month: 00 |
| `%f` | fractional seconds: SS.SSS |
| `%H` | hour: 00-24 |
| `%j` | day of year: 001-366 |
| `%J` | Julian day number |
| `%m` | month: 01-12 |
| `%M` | minute: 00-59 |
| `%s` | seconds since 1970-01-01 |
| `%S` | seconds: 00-59 |
| `%w` | day of week 0-6 with Sunday==0 |
| `%W` | week of year: 00-53 |
| `%Y` | year: 0000-9999 |
| `%%` | % |

Notice that all other date and time functions can be expressed in terms of strftime():

| Function | Equivalent strftime() |
|----------|-----------------------|
| `date(...)` | `strftime('%Y-%m-%d', ...)` |
| `time(...)` | `strftime('%H:%M:%S', ...)` |
| `datetime(...)` | `strftime('%Y-%m-%d %H:%M:%S', ...)` |
| `julianday(...)` | `strftime('%J', ...)` |

The only reasons for providing functions other than strftime() is for convenience and for efficiency.

## Time Format String

| String |
|--------|
| `YYYY-MM-DD` |
| `YYYY-MM-DD HH:MM` |
| `YYYY-MM-DD HH:MM:SS` |
| `YYYY-MM-DD HH:MM:SS.SSS` |
| `YYYY-MM-DDTHH:MM` |
| `YYYY-MM-DDTHH:MM:SS` |
| `YYYY-MM-DDTHH:MM:SS.SSS` |
| `HH:MM` |
| `HH:MM:SS` |
| `HH:MM:SS.SSS` |
| `now` |
| `DDDDDDDDDD` |

## Modifiers

The time string can be followed by zero or more modifiers that alter date and/or time. Each modifier is a transformation that is applied to the time value to its left. Modifiers are applied from left to right; order is important. The available modifiers are as follows.

| Modifiers |
|-----------|
| `NNN days` |
| `NNN hours` |
| `NNN minutes` |
| `NNN.NNNN seconds` |
| `NNN months` |
| `NNN years` |
| `start of month` |
| `start of year` |
| `start of day` |
| `weekday N` |
| `unixepoch` |
| `localtime` |
| `utc` |

## Examples

| Example | Description |
|---------|-------------|
| `SELECT date('now');` | Compute the current date. |
| `SELECT date('now','start of month','+1 month','-1 day');` | Compute the last day of the current month. |
| `SELECT datetime(1092941466,'unixepoch');` | Compute the date and time given a unix timestamp 1092941466. |
| `SELECT datetime(1092941466,'unixepoch','localtime');` | Compute the date and time given a unix timestamp 1092941466, and compensate for your local timezone. |
| `SELECT strftime('%s','now');` | Compute the current unix timestamp. |
| `SELECT julianday('now')-julianday('1776-07-04');` | Compute the number of days since the signing of the US Declaration of Independence. |
| `SELECT strftime('%s','now') - strftime('%s','2004-01-01 02:34:56');` | Compute the number of seconds since a particular moment in 2004: |
| `SELECT date('now','start of year','+9 months','weekday 2');` | Compute the date of the first Tuesday in October for the current year. |
| `SELECT (julianday('now')-2440587.5)*86400.0;` | Compute the time since the unix epoch in seconds (like strftime('%s','now') except includes fractional part): |

# Explain Plan

```sql
EXPLAIN QUERY PLAN
SELECT *
FROM   tab
WHERE  col = 'bloggs';
```

# Load CSV Data

```sql
.mode csv
.import file.csv table_name
```

<hr>
