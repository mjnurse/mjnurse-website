---
title: Simplified Backus-Naur Form - BNF
---

`[ ]` Brackets enclose optional items.

`{ }` Braces enclose items only one of which is required.

`|` A vertical bar separates alternatives within brackets or braces.

`...` Ellipsis points show that the preceding syntactic element can be repeated.

Example

```
<full-name> ::== <title> <firstname> [<middlename>]... <surname>
<title> ::== {Mr|Mrs|Ms}
<firstname> ::== <name>
<name> ::== <uppercaseletter><lowercaseletter>[<lowercaseletter>]...
<uppercaseletter> ::== {A|B|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z}
<lowercaseletter> ::== {a|b|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z}
etc...
```
<hr>
