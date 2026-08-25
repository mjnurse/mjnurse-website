---
title: Oracle
---
# A Dynamic SQL For Loop

```
DECLARE
   TYPE name_salary_rt IS RECORD (
   ( name   VARCHAR2 (1000)
   , salary NUMBER
   );
 
   TYPE name_salary_aat IS TABLE OF name_salary_rt INDEX BY PLS_INTEGER;
 
   l_employees   name_salary_aat;
BEGIN
   EXECUTE IMMEDIATE
      q'[SELECT   first_name || ' ' || last_name, salary 
         FROM     hr.employees
         ORDER BY salary desc]'
      BULK COLLECT INTO l_employees;
 
   FOR indx IN 1 .. l_employees.COUNT
   LOOP
      DBMS_OUTPUT.put_line (l_employees (indx).name);
   END LOOP;
END;

```
<hr>
