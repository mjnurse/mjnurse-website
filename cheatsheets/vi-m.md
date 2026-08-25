---
title: ViM CheatSheet
contents-list: h1,h2
---

# ViM Cheat Sheet

## Navigation

| `h, j, k, l` | Move cursor left, down, up, right |
| `w` | Jump to start of next word (W - words inc. punctuation) |
| `e` | Jump to end of next word (E - words inc. punctuation) |
| `b` | Jump to start of previous word (B - words inc. punctuation) |
| `0` | Jump to the start of the line |
| `^` | Jump to the first non-blank character of the line |
| `$` | Jump to the end of the line |
| `}, {` | Jump to next, previous paragraph |

## Cut and paste

| `yy` | Yank (copy) a line (2yy - 2 lines) |
| `yw` | Yank (copy) word |
| `y$` | Yank (copy) to end of line |
| `p` | Paste the clipboard after cursor (P - before) |
| `dd` | Delete a line (2dd - 2 lines) |
| `dw` | Delete word |
| `D` | Delete to the end of the line |
| `d$` | Delete to the end of the line |
| `x` | Delete character |

## Marks

| `m[a-z]` | Create a mark labelled a,b,c..z |
| `'[a-z]` | Jump to mark a.b.c..z (or use in range) |

## Editing

| `i` | Insert before cursor (I - beginning of line) |
| `a` | Insert after cursor (A - end of line) |
| `o` | Append (open) a new line below the current line |
| `O` | Append (open) a new line above the current line |
| `ea` | Insert (append) at the end of the word |
| `Esc` | Exit insert mode |
| `r` | Replace a single character (R - replace until Esc.) |
| `J` | Join line below to the current one |
| `cc` | Replace entire line |
| `cw` | Replace to the end of the word |
| `c$` | Replace to the end of the line |
| `s` | Delete character and substitute text |
| `S` | Delete line and substitute text (same as cc) |
| `xp` | Transpose two letters (delete and paste) |
| `u` | Undo (Ctrl+r - redo) |
| `.` | Repeat last command |
| `~` | Switch case |
| `guw gUw` | Lower, upper case from current char to end word |

### Operator - Text Object - Motion

Operator: **d**elete, **c**hange, **v**isual select , **r**eplace

Text Object: **i**nside, **a**round

Motion:

| `w` | word |
| `W` | WORD (includes special chars) |
| `b` or `(` | block (of parentheses) |
| `B` or `{` | BLOCK (of curly braces) |
| `[` | brackets |
| `'` | single quotes |
| `"` | double quotes |
| `t` | tag (html or xml <tag></tag>) |
| `p` | paragraph |
| `s` | sentence |

eg.

| `di{` | delete text inside the { } brackets |
| `vo"` | visual select of text inside and including "'s |

## Macros

| `q[a-z]` | Start recording macro named a,b,c..z. q ends recording |
| `@[a-z]` | Replay macro named a,b,c..z |

## Search Replace

`:<range>s/<search string>/<replace string>[/cgiI]`

| `c` | Confirm each replacement |
| `g` | All instances on a line |
| `i` | Ignore case (I - don't ignore case) |

## Range

| `num` | An absolute line number |
| `.` | The current line |
| `$` | The last line in the file |
| `%` | The whole file. |
| `'t` | Position of mark "t" |
| `n..m` | Lines numbered n to m inclusive |

## Escaped Characters

| `.` | Any character except new line (.* - includes empty lines) |
| `\.` | . character |
| `\s` | Whitespace character (\S - non-whitespace character) |
| `\d` | Digit (\D - non-digit) |
| `\x` | Hex digit (\X - non-hex digit) |
| `\o` | Octal digit (\O - non-octal digit) |
| `\h` | Head of word character (a,b,c...z,A,B,C...Z and _) (\H - non-head of word character) |
| `\p` | Printable character (\P - excluding digits) |
| `\w` | Word character (\W - non-word character) |
| `\a` | Alphabetic character (\A - non-alphabetic character) |
| `\l` | Lowercase character (\L - non-lowercase character, more than A..Z) |
| `\u` | Uppercase character (\U - non-uppercase character, more than a..z) |
| `*` | Matches 0 or more of the preceding characters, ranges or metacharacters |
| `\+` | Matches 1 or more of the preceding characters |
| `\=` | Matches 0 or 1 more of the preceding characters |
| `\{n,m}` | Matches from n to m of the preceding character |
| `\{n}` | Matches exactly n times of the preceding characters |
| `\{,m}` | Matches at most m (from 0 to m) of the preceding characters |
| `\{n,}` | Matches at least n of of the preceding characters |
| `\{-}` | Matches 0 or more of the preceding atom, as few as possible |
| `\{-n,m}` | Matches 1 or more of the preceding characters |
| `\{-n,}` | Matches at lease or more of the preceding characters |
| `\{-,m}` | Matches 1 or more of the preceding characters |

## String Ranges

| `[0123abAC]` | Matches any of the characters inside the brackets |
| `[a-zA-Z0-9]` | Matches lowercase characters, uppercase characters and digits |
| `[^a-zA-Z0-9]` | Matches anything but [a-zA-Z0-9] "^" will lose its special meaning if it's not the first character in the range. |

## Using Matched Characters In Replacement String

Search strings inside "\(" and "\)" can be used in replacement string reference as \1, \2 etc

Replacement String Special Character

| `\0` | The whole matched pattern |
| `\L` | The following characters are made lowercase (terminate with \E or \e) |
| `\U` | The following characters are made uppercase (terminate with \E or \e) |
| `\l` | Next character made lowercase |
| `\u` | Next character made uppercase |
| `\r` | Split line in two at this point |
| `&` | The whole matched pattern |
| `~` | The previous substitute string |

## Alternations

" | `" can combine several expressions into one. The first one matched will be used.
eg. `\(Date: | Subject: | From:\)\(\s.*\)` - matches Date: or Subject: first then whitespace.

## Regexp Operator Precedence

| 1 | Grouping | `\(\)[a-zA-Z0-9]` |
| 2 | Quantifiers | `\=,\+,*,\{n} etc.` |
| 3 | Characters | Sequence of characters/metacharacters` |
| 4 | Alternation | `[a-zA-Z0-9]` |

## Global Command - Global search and execution

`:<range>g[!]/<pattern>/<cmd>`

Execute the Ex command <cmd> (default ":p") on the lines within <range> where <pattern matches >. !<pattern> only line which don't match.

Example Ex commands :s[ubstitute], :co , :d[elete], :w[rite] etc.

eg. `:g/^$/d` - delete all empty lines in a file.
eg. `:g/^$/,/./-j` - reduce multiple blank lines to a single blank.
eg. `:10,20g/^/ mo 10` - reverse the order of the lines starting from the line 10 up to the line 20.

## Misc

`:set ic` - ignore case, `:set noic`, `:set ic!` - toggle.

## vimrc

`.vimrc` file:
```vim
set hlsearch
set incsearch
set ic

" Lets put all the filename~ backup and swp / un file in the temp folder.
set backupdir=/tmp
set directory=/tmp
set undodir=/tmp

" 3 Character tab and convert these to spaces.
set tabstop=3 softtabstop=0 expandtab shiftwidth=3
let b:did_indent = 1

" Map F2 to auto complete words in inset mode and to clear the last search otherwise.
map! <F2> <C-N>
map  <F2> :noh<CR>

" Enable spell check.
set spell spelllang=en_gb
set spellfile=~/.vimspellfile.add
set spellcapcheck=""

map <C-n> ]s
map <C-p> [s
map <C-l> z=
map <C-k> zg

" Stop the bloody ping on error and flash the screen instead.
set vb

" set columns=110

map <C-D> 110A-<ESC>A<CR><ESC>

" Python (.py) specific indents
au BufNewFile,BufRead *.py
    \ set tabstop=3 |
    \ set softtabstop=3 |
    \ set shiftwidth=3 |
    \ set textwidth=109 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" set foldmethod=indent
" map <C-F> zc
" map <A-left> zc
```

<hr>
