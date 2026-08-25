---
title: 19-06-12 - Setting Prompt Colour In bash and Putty
section: LinuxBash
---

I want a different colour prompt for different machines.

The following script gives colour names to the various escape sequences.  Can put this in (for example) .bashrc file.

```
# Regular Text Colours
txtblk='\e[0;30m' # Black
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White

# Bold Text Colours
bldblk='\e[1;30m' # Black
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White

# Underlined Text Colours
unkblk='\e[4;30m' # Black
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White

# Background Colours
bakblk='\e[40m'   # Black
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset
```
The following sets the prompt text and with colour.
```
export PS1="${txtcyn}"'\u@\h '"${txtred}"'\W> '"${txtwht}"
```
It is preferable to use single quotes but within single quotes the colour variables do not get replaced so here I use a mixture of double and single quotes.

The following variables can be used in the prompt.
```
\d   The date, in "Weekday Month Date" format (e.g., "Tue May 26"). 

\h   The hostname, up to the first . (e.g. deckard) 
\H   The hostname. (e.g. deckard.SS64.com)

\j   The number of jobs currently managed by the shell. 

\l   The basename of the shells terminal device name. 

\s   The name of the shell, the basename of $0 (the portion following the final slash). 

\t   The time, in 24-hour HH:MM:SS format. 
\T   The time, in 12-hour HH:MM:SS format. 
\@   The time, in 12-hour am/pm format. 

\u   The username of the current user. 

\v   The version of Bash (e.g., 2.00) 
\V   The release of Bash, version + patchlevel (e.g., 2.00.0) 

\w   The current working directory. 
\W   The basename of $PWD. 

\!   The history number of this command. 
\#   The command number of this command. 

\$   If you are not root, inserts a "$"; if you are root, you get a "#"  (root uid = 0) 

\nnn   The character whose ASCII code is the octal value nnn. 

\n   A newline. 
\r   A carriage return. 
\e   An escape character (typically a color code). 
\\   A backslash. 

\[   Begin a sequence of non-printing characters. (like color escape sequences). This
     allows bash to calculate word wrapping correctly.
\]   End a sequence of non-printing characters.
```

<hr>
