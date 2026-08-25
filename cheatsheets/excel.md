---
title: Excel Cheat Sheet
contents-list: h1,h2
---
# Features

## 2d Lookup

Using `MATCH` and `INDEX`.

<table>
  <tr><td> </td><th>A    </th><th>B  </th><th>C  </th><th>D  </th></tr>
  <tr><th>1</th><td>     </td><td>Cat</td><td>Dog</td><td>Cow</td></tr>
  <tr><th>2</th><td>White</td><td>30%</td><td>25%</td><td>80%</td></tr>
  <tr><th>3</th><td>Brown</td><td>30%</td><td>45%</td><td>10%</td></tr>
  <tr><th>4</th><td>Black</td><td>40%</td><td>30%</td><td>10%</td></tr>
</table>

To find the percentage of Dogs that are White

```
=INDEX(A1:D4,MATCH("Dog",A1:A4,0),MATCH("White",A1:D1,0))
```

## Tables and =[@ColName] Notation

References a column in a table.  First Insert - Table.

`=[@ColName]` references the value in a column on the same row in the table.

`=[ColName]` references all values in a column in a table so you will need an aggregation type function to use this in a table.

`=[@[Col Name]]` Note the extra brackets required if column name includes spaces.

Min Temp | Max Temp | Avg Temp | Highest Overall Temp
---|---|---|---
`12` | `34` | `=([@[Min Temp]]+[@[Max Temp]])/2` | `=max([Max Temp])`

Function Definitions

```
=INDEX(array, row_num, col_num)
=MATCH(lookup_value, array, match_type) - Note: Match type 0 means exact
```

## Determine if a Column is Visible

Will return 1 if visible, 0 otherwise.

```
=N(CELL("width",A1)>0)
```

## Define New Functions using LAMBDA

You can create a function using LAMBDA, eg:

```
=LAMBDA(amount, interest_perc, amount*(1+interest_perc/100))
```

The first n - 1 LAMBDA parameters are parameter names, the final LAMBDA parameter is the function.

To pass in values, you add these after the LAMBDA function, eg:

```
=LAMBDA(amount, interest_perc, amount*(1+interest_perc/100))(A1, B1)
```

To make this function reusable, go to the Formulas menu, Name Manager.  Create `New`, give the function a name, and add the LAMBDA definition to the `Refers To` section.  You can then use this function elsewhere, eg:

```
=myFunction(A1, B1)
```

# Functions

## Compound Growth / Interest

| <img src="/Cheatsheets-C/images/excel-compound-growth.png" width="800"> |

## Bytes Size String to Number

A function to convert size in bytes value strings (eg 12gb, 3mb etc) to a number.

Option 1:

```
=LET(col,A1,
     IFERROR(SUBSTITUTE(LOWER(col),"b","")/2^30,
             LEFT(col,LEN(col)-2)*
             SWITCH(RIGHT(LOWER(col),2),"tb",2^10,"gb",1,"mb",1/2^10,"kb",1/2^20,-1)))
```

### Function In Use

![](/Cheatsheets-C/images/excel_size_string.png)

## Columns To SQL Insert Statement

A function to create a SQL create table statement and SQL insert statements for 1 - 10 columns of data.

Row 1 contains the column names, row 2 the data types (s - string or n - number).  Row 3 onwards is data.

Two functions, the first goes on row 1 column 11 (k) and creates the create table statement.  The second goes along side every row of data in column 11 (k).

### Create table create statement

```
="CREATE TABLE tab ( "&A1&" "&IF(A$2="s","VARCHAR2(4000)","NUMBER")
&IF(B$1<>"",", "&B$1&" "&IF(B$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(c$1<>"",", "&c$1&" "&IF(c$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(d$1<>"",", "&d$1&" "&IF(d$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(e$1<>"",", "&e$1&" "&IF(e$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(f$1<>"",", "&f$1&" "&IF(f$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(g$1<>"",", "&g$1&" "&IF(g$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(h$1<>"",", "&h$1&" "&IF(h$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(i$1<>"",", "&i$1&" "&IF(i$2="s","VARCHAR2(4000)","NUMBER"),"")
&IF(j$1<>"",", "&j$1&" "&IF(j$2="s","VARCHAR2(4000)","NUMBER"),"") 
& " );"
```

### Create insert statement

```
="INSERT INTO tab ("&A$1
&IF(B$1<>"",", "&B$1,"")
&IF(C$1<>"",", "&C$1,"")
&IF(D$1<>"",", "&D$1,"")
&IF(E$1<>"",", "&E$1,"")
&IF(F$1<>"",", "&F$1,"")
&IF(G$1<>"",", "&G$1,"")
&IF(H$1<>"",", "&H$1,"")
&IF(I$1<>"",", "&I$1,"")
&IF(J$1<>"",", "&J$1,"")
&" ) VALUES ( "
&IF(A$2="s","'"&A3&"'",A3)
&IF(B$1<>"",", "&IF(B$2="s","'"&B3&"'",B3),"")
&IF(C$1<>"",", "&IF(C$2="s","'"&C3&"'",C3),"")
&IF(D$1<>"",", "&IF(D$2="s","'"&D3&"'",D3),"")
&IF(E$1<>"",", "&IF(E$2="s","'"&E3&"'",E3),"")
&IF(F$1<>"",", "&IF(F$2="s","'"&F3&"'",F3),"")
&IF(G$1<>"",", "&IF(G$2="s","'"&G3&"'",G3),"")
&IF(H$1<>"",", "&IF(H$2="s","'"&H3&"'",H3),"")
&IF(I$1<>"",", "&IF(I$2="s","'"&I3&"'",I3),"")
&IF(J$1<>"",", "&IF(J$2="s","'"&J3&"'",J3),"")
&" );"
```

### Function In Use

![](/Cheatsheets-C/images/excel_table_insert.png)

## Strip Numbers From A String

```
=TEXTJOIN("",TRUE,IF(ISERR(MID(A1,ROW(INDIRECT("1:100")),1)+0),MID(A1,ROW(INDIRECT("1:100")),1),""))
```

## Shortcut Keys

| SHIFT + SPACE | Select entire row |
| CTRL + SPACE | Select entire column |
| CTRL +  | Show all formulas |

