---
title: Python Cheatsheet
contents-list: h1,h2
---

## Strings

```python
my_string * n # Repeat my_string n times
my_string.upper()
my_string.lower()

str_pos = my_string.find(str_to_find, start_pos, end_pos) # default start=0, end=string_length

""" - triple quote or triple double quote enclose a multi line string
```

### String format function

```python
'Hello {} aged {}'.format('Martin', '21')       # yields Hello Martin aged 21
'Hello {1} aged {0}'.format('21', 'Martin')     # yields Hello Martin aged 21
# float format (use d for integer)
'{0} is {1:.2f} tall'.format('Martin', 1.849)   # yields Martin is 1.85 tall
'{0} is {1:.0f} tall'.format('Martin', 1.849)   # yields Martin is 2 tall
'{0} is {1:10.1f} tall'.format('Martin', 1.849) # yields Martin is      1.9 tall
# comma number format
'{:,} | {:>7,}'.format(12345, 4321) # yields 12,345 |   4,321
# padding
'|{0:10}|{1:>10}|{2:^10}|'.format('lpad','rpad','midpad') # yields |lpad      |      rpad|  midpad  |
'{0:.^20}'.format('middle of dots')                       # yields ...middle of dots...
# truncate a string
'|{0:3.3}|{1:6.3}'.format('Martin', 'Martin') # yields |Mar|Mar   |
```

### Regexp

```python
import re
my_name = re.search(my_str, '.*: ([^ ]*) .*', 'Name: Martin, Age: 18')
if re.match(my_name + '.*', my_str):
new_str = re.sub(r'^[^-]*- ', r'', line)
```

## Lists

```python
my_list = [1, 3, 4, 'a', {"name":"martin"}] # many types, single list
len(my_list)
```

```python
my_list.append('red')
my_list.insert(2, 'red')    # insert at position 2
del my_list[2]              # remove index 2
my_list.remove('red')       # remove the first instance of the value red
v = my_list.pop()           # remove and use last item in the list
v = my_list.pop(0)          # remove and use first item in the list
my_list = list(range(1,11)) # list of numbers 1 to 10
```

```python
if 'martin' in vips:        # check if item in list
```

```python
my_list_2 = my_list         # my_list_2 points to the SAME LIST as my_list
new_list = my_list[:]       # new list copy of my_list
new_list = sorted(my_list)  # can add parameter reverse=True
my_list.sort()              # can add parameter reverse=True
my_list.reverse()           # reverse items in list
```

```python
sum(my_list)                # avg = sum(my_list) / len(my_list)
min(my_list)
max(my_list)
```

```python
# Note the list slices are new list objects. slice [:] is all elements
my_list = ['a','b','c','d','e']
my_list[:3]                 # yields: ['a','b','c'] - same a [0:3]
my_list[3:]                 # yields: ['d','e'] = from pos to end of list
my_list[-3:]                # yields: ['c','d','e']
my_list[2:3]                # yields: ['c']
my_list[2:2]                # yields: []
[x**2 for x in range(1, 4)] # yields: [1,4,9]
```

```python
for item in list: 
for c in 'orange':          # loop through characters in string
```

```python
# Sorting dict's in a list
my_list = [{"name","tom"},{"name":"bill"}]
def my_key(a_dict): return a_dict['name']
my_list.sort(key = my_key)
```

## Tuples

```python
(1,2,3) + (4,5) + (6,) # yields (1,2,3,4,5,6)
t = (1,2,3); t[0,2]    # yields (1,2)
```

## Dictionaries

```python
d1 = {'key','value'}
d2 = d1       # d2 and d2 both 'point' to the same dictionary
d3 = dict(d1) # Creates a copy of d1
```

Sorting by Key  or Value

```python
d={'b':0, 'a':1}
sorted(d.keys())                             # yields ['a','b']
sorted(d.items(), key=lambda item: item[1]): # yields [('b', 0), ('a', 1)]
```

## Loops

```python
for i in range(1,10):
```

## File Handling

```python
# Read:
fh = open("hello.txt", "r")
whole_file_str = fh.read()
single_line = fh.readline()
list_of__lines = fh.readlines()

# Write:
fh = open("hello.txt", "w")
fh.write(str)
lines_of_text = ["a line of text", "another line of text", "a third line"]
fh.writelines(lines_of_text)

# Append:
fh = open("Hello.txt", "a")
write(str)

# Close:
fh.close()
```

## Command Line Parameters

```python
import sys
print( sys.argv[0] ) # The script/program name
for p in sys.argv: print(i)
```

## In-line if

```python
print('lower' if a < b else 'not lower')
```

## Useful

## `__main__`
The method main() is only run if this file is being executed rather than imported.  Good for running unit test in a library.

```python
if __name__ == "__main__":
   main()
```

## Pretty Print JSON

```python
import json
print(json.dump(json_var, indent=3, sort_keys=True)
```

## Clear the screen

```python
from os import system, name 
if name == 'nt': # windows 
   _ = system('cls') 
else: # linux etc
   _ = system('clear') 
```

## OS Operations
Using the Windows Linux (Ubuntu) sub-system.

```python
os.listdir("/mnt/c/...")
os.remove('/mnt/c/MJN/tmp/dme')
```

## Variable Set of Arguments
args(*) - delivers a tuple containing a set of (unnamed) values

```python
def multiply_all(*values): 
   mul = 1 
   for i in values: 
      mul = mul * i 
  
   return mul 
```

kwargs(*) - delivers a dict containing keywords and values

```python
def print_details(**details): 
   print "First Name = ", details['first_name'] 
   print "Department = ", details['department'] 
  
print_details(first_name = "Martin", agent = "007", department = "MI6") 
print_details(first_name = "Q", department = "Research") 
```

## Colours In Command Line Output

```python

# This command required to get colours working in windows cmd wrapped bash shells.
os.system('') 

# Colours

RESET = '\x1b[0m'
BRIGHT = '\x1b[1m'
DIM = '\x1b[2m'
UNDERSCORE = '\x1b[4m'

FGBLACK = '\x1b[30m'
FGRED = '\x1b[31m'
FGGREEN = '\x1b[32m'
FGYELLOW = '\x1b[33m'
FGBLUE = '\x1b[34m'
FGMAGENTA = '\x1b[35m'
FGCYAN = '\x1b[36m'
FGWHITE = '\x1b[37m'

BGBLACK = '\x1b[40m'
BGRED = '\x1b[41m'
BGGREEN = '\x1b[42m'
BGYELLOW = '\x1b[43m'
BGBLUE = '\x1b[44m'
BGMAGENTA = '\x1b[45m'
BGCYAN = '\x1b[46m'
BGWHITE = '\x1b[47m'
```

