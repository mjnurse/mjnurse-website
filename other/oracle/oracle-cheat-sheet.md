---
title: Oracle
---
# Oracle Cheat Sheet

### Redirect Multiple Lines To SQLPLUS
```
sqlplus -s /NOLOG <<EOF
CONN user/pwd@//0.0.0.0.0:1521/ORCL 
SELECT 1
FROM   dual;
EOF
```

### Create a User With DBA Role
```
> create user mjn identified by mjn;
User created.

> GRANT CONNECT, RESOURCE, DBA TO mjn;
Grant succeeded.

> GRANT CREATE SESSION TO mjn;
Grant succeeded.

> GRANT UNLIMITED TABLESPACE TO mjn;
Grant succeeded.
```
### SQLPLUS Variables

#### Using Substitution Variables
A character substitution variable can be up to 240 bytes long.
```
> DEFINE name = 'King'

> ACCEPT name CHAR PROMPT 'Enter a last name: '

-- Show the value.
> DEFINE name
DEFINE name  = "King" (CHAR)

-- Show all values.
> DEFINE
DEFINE name  = "King" (CHAR)
DEFINE name2 = "Taylor" (CHAR)

-- Use in SQL.  If its doesn't exist will be prompted.
> SELECT '&name' FROM dual;

-- Difference Between "&" and "&&" Prefixes. "&" will re-prompt "&&" won't.

> DEFINE c=8
> DEFINE d=9
> SELECT &a, &a, &&b, &&b, &c, &c, &&d, &&d FROM dual;
Enter value for a: 1
Enter value for a: 2
Enter value for b: 3

     1      2      3      3      8      8      9      9
------ ------ ------ ------ ------ ------ ------ ------
     1      2      3      3      8      8      9      9

-- Storing a Query Column Value in a Substitution Variable.

> COLUMN last_name NEW_VALUE last_name
> SELECT last_name FROM employees WHERE employee_id = 100;

> UNDEFINE a b c d
```

#### Predefined Substitution Variables
```
_CONNECT_IDENTIFIER _DATE _EDITOR _O_RELEASE _O_VERSION _PRIVILEGE _SQL_ID _SQLPLUS_RELEASE _USER
```
#### Other substitution Variables.

`&1`, `&2`, `&3` command line variables.  Can pass in strings with spaces in quotes: `"one two"`.

NOTE: You CANNOT use a substitution variable as the first token of a command.
```
> &cmd * from dual; -- Will error
```

### Using Bind Variables
```
> VARIABLE var NUMBER
> EXEC :var := 8

--  In SQLPlus 12.2
> VARIABLE var NUMBER = 8

> PRINT var

--Numeric bind variables can be used in the EXIT command to return a value to the operating system:
> EXIT :numeric-var

-- Assigning Bind Variables to Substitution Variables.
> VARIABLE mybv VARCHAR2(14)
> EXEC :mybv := 'report.log';

-- Pass the bind variable's value to a new substitution variable "nv" by using a query:
> COLUMN mybvcol NEW_VALUE nv NOPRINT
> SELECT :mybv AS mybvcol FROM dual;
```

#### SET DEFINE / SET ESCAPE

Use SET DEFINE OFF to stop SQLPlus performing any variable substitution. This makes SQLPlus treat all ampersands (&) as literal characters.
```
> SET ESCAPE \
> SELECT 'B\&W' myHeading FROM dual;
```
<hr>
