---
title: DOS - Cmd Cheat Sheet
contents-list: h1,h2
---

# Variables

```bat
SET b=%a:x=y%   # Replace 'x' with 'y'.
SET b=%a:xy=%   # Delete the string 'xy'.
SET b=%a:*xy=%  # Delete the string 'xy' and everything before it.
SET b=%a: =%    # Remove spaces from a string.

SET s=martin
ECHO %s:~1%     # Yeilds: artin
ECHO %s:~,-2%   # Yields: mart
ECHO %s:~1,-1%  # Yields: arti
ECHO %s:~1,2%   # Yields: ar
```

To remove characters from the right hand side of a string is a two step process - To delete everything after the string 't':

```bat
SET a=Martin
SET tmp=%a:*t=%          # Create tmp string removing 't' and everything before it.
CALL SET b=%%a:%tmp%=%%  # Remove tmp from original string.  Use CALL to expand tmp before replace.
```

Boolean Test "does string exist ?" - To test for string 'Three':

```bat
SET a="One, Two, Three"
SET tmp=%a:Three=%      # Create tmp string removing 'Three' if it exists, then compare or original.
IF NOT %tmp% == %a% (ECHO found.) ELSE (ECHO Not found.)
```

## Variable Substitution

| `%~V` | expands %V removing any surrounding quotes (") |
| `%~fV` | expands %V to a fully qualified path name |
| `%~dV` | expands %V to a drive letter only |
| `%~pV` | expands %V to a path only (directory with \) |
| `%~nV` | expands %V to a file name only |
| `%~xV` | expands %V to a file extension only |
| `%~sV` | expanded path contains short names only |
| `%~aV` | expands %V to file attributes of file |
| `%~tV` | expands %V to date/time of file |
| `%~zV` | expands %V to size of file |

## Environment Variables

```bat
setx <var_name> <var_value> [/M]
```

`/M` makes this a System variable rather than User variable.  `/M` requires administrator privileges.

# Read user Input

```
set /p "value=Enter value: "
echo %value%
```

# IF Condition

## File syntax

```bat
IF [NOT] EXIST filename command 
IF [NOT] EXIST filename (command) ELSE (command)
```

## String syntax

```bat
IF [/I] [NOT] item1==item2 command   # /I - case insensitive.
IF [/I] item1 compare-op item2 command
IF [/I] item1 compare-op item2 (command) ELSE (command)

IF [%1]==[] ECHO Value Missing  # Check for missing command line parameter.  (can use EQU in place of ==)

# Compare-op can be: EQU (==), NEQ (!=), LSS (<), LEQ (<=), GTR (?), GEQ (>=).
# (This syntax is necessary because the > and < symbols are redirection operators)

# The == comparison operator always results in a string comparison.  EQU will compare numbers.

# Filenames/Paths - Always surround them with quotes: if %_myvar% contains "C:\Some Path" then 
# comparison becomes IF ["C:\Some Path"] EQU []
```

## Error Check Syntax

```bat
IF [NOT] DEFINED variable command  # Note: DEFINED will return true for a space character.
IF [NOT] ERRORLEVEL number command 
IF CMDEXTVERSION number command
```

## Parenthesis

Parenthesis can be used to split commands across multiple lines.

```bat
IF EXIST filename.txt (
    ECHO Deleting filename.txt
    DEL filename.txt
 ) ELSE (             # Note: Always put the parenthesis on the same line as ELSE.
    ECHO The file was not found.
 )
```

## An AND test:

```bat
IF SomeCondition (
   IF SomeOtherCondition (
     Command_if_both_are_true
   )
)
```

## An OR test:

```bat
SET "tmp="
IF SomeCondition SET tmp=1
IF SomeOtherCondition SET tmp=1
IF %tmp% EQU 1 Command_to_run_if_either_is_true
```

### Notes: 

- Delimiters - If the string being compared includes delimiters such as [Space] or [Comma], then the delimiters must be escaped with a caret ^ or the whole string must be "quoted".
- Wildcards - Wildcards are not supported by IF.  Use variable string transforms instead.

# Loops

```bat
FOR %%f IN (file1.txt file2.txt) DO ECHO %%f
FOR /L %%i IN (0,2,10) DO ECHO %%i # Yields 0 2 4 6 8 10
FOR /F %%l IN (file.txt) DO ECHO %%l

# delims= overrides default space delimiter so whole line is a single token
FOR /F "delims=" %%line IN (file.txt) DO ECHO %%line
# tokens=* overrides default token=1 to return all tokens using the default space delimiter
FOR /F "tokens=*" %%line IN (file.txt) DO ECHO %%line
FOR /F "tokens=*" %%character IN ("I am cool") DO ECHO %%character
FOR /F "tokens=*" %%l IN ('DIR /B') DO ECHO %%l
```

# Other

-  To echo the > symbol use: ^>
-  To echo the % symbol use: %%
-  To exit script but not the cmd.exe: `exit /B`

## Setting File Attributes

-  `attrib -r <filename>` - removes readonly

# Working with tasks (processes):

```bat
:: List tasks
> tasklist

:: Kill task
taskkill /F /PID <pid_number>
taskkill /IM <"process name"> /F
```

# An example script to process command line parameters

```bat
@ECHO OFF
SETLOCAL EnableDelayedExpansion
(SET n=^
%doNotDeleteThisLine%
)
GOTO :START

:HELP
ECHO !n!^
A sample script to parse command line parameters. !n!^
                                                  !n!^
process-params [/D] [/H] [/V value]               !n!^
                                                  !n!^
  /D   Enable Debug.                              !n!^
  /H   Displays this help.                        !n!^
  /V   Sets variable value.                       !n!

EXIT /B
:START

SET debugYN=N
SET val=

:LOOP
  IF [%1]==[] GOTO :END_LOOP
  SET par=%1
  SHIFT

  IF [%par%]==[/H] (
    GOTO :HELP
  )

  IF [%par%]==[-d] (
    SET debugYN=Y
    GOTO :LOOP
  )

  IF [%par%]==[-v] (
    SET val=%1
    SHIFT
    GOTO :LOOP
  )

  ECHO NOT PROCESSED %par%
  GOTO :LOOP
:END_LOOP

ECHO debugYN: %debugYN%
ECHO value:   %val%
```

# A script to emulate the linux sudo command:

Create a script `sudo.bat`:

```bat
@echo Set objShell = CreateObject("Shell.Application") > %temp%\sudo.tmp.vbs
@echo args = Right("%*", (Len("%*") - Len("%1"))) >> %temp%\sudo.tmp.vbs
@echo objShell.ShellExecute "%1", args, "", "runas" >> %temp%\sudo.tmp.vbs
@cscript %temp%\sudo.tmp.vbs
```

To open a new cmd window running as administrator:

```bat
> sudo cmd
```

I did have some issues if I pass in multiple parameters to sudo, but I'll leave that for another day.

# Other

```bat
:: Get current directory
SET curr_dir=%cd%
```

<hr>
