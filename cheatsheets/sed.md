---
title: sed Cheatsheet
contents-list: h1,h2
---
## Overview

`-i` - edit file in place.

## 3 solutions to only output matching lines:

```
> cat file | sed -n "/abc/p"

# Without -n option.  t - skips all further commands, d - deletes the line.
> cat file | sed "s/\(abc\)/\1/;t;d"

# As above but also print first line.
> cat file | sed "1p;t; s/\(abc\)/\1/;t;d"
```

## Only output lines up to but not including the line with the SEARCH-STRING.

```
> sed -n '/^SEARCH-STRING/q;p' file
```

## Only print lines after and including the line with the SEARCH-STRING.

```
> sed -n '/^SEARCH-STRING/,$p' file
```

## Delete text between two matching lines

```
# Delete including matching lines
> cat file | sed sed '/^startstring/,/^endstring}/d'

# Delete excluding matching lines
> cat file | sed sed '/^startstring/,/^endstring}/{//!d;}'
```

## Case insensitive search/replace

```
sed 's/one/two/I'
```

## Edit first line only

```
sed -i "1s/hello/goodbye/" <file>
```
