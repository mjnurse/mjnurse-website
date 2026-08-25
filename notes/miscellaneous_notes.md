# Miscellaneous Notes

The notes captured in the Linux notes tool = `n`.

### 7zip

|||
|---|---|
|`7z a -p -mhe=on archive.7z <files_or_folders>`|-mhe=on - encrypt file contents and filenames/headers.|


### ES

|||
|---|---|
|`@esql 'SELECT id.value FROM "mdm-example-entity-store-business-all-data"'`|Elasticsearch SQL|


### Excel

|||
|---|---|
|Open Drop-down in Cell - ALT-DOWN_ARROW||


### Windows

|||
|---|---|
|WIN-H - turn on dictation||


### apt

|||
|---|---|
|`sudo apt autoclean`|tidy the package cache|
|`sudo apt autoremove`|remove not required dependencies|
|`sudo apt install ./download/apt.deb`|install deb files|


### awk

|||
|---|---|
|`cmd \|\| awk '{print $1, $3}'`|print 1st and 3rd space separated columns|


### bash

|||
|---|---|
|`!! !<abc> !!:p !<abc>:p`|Run last command (:p - print command)|
|`!^ !$ !:2 !:2-4`|First, Last, 2nd, 2nd to 4th arguments from prev command (!:0 is last command)|
|`#!/usr/bin/env bash`|First line bash script|
|`cp file.txt{,.bak}`|cp file.txt file.txt.bak|
|`echo {0..10..2}`|0 -> 10 in steps of 2: 0 2 4 6 8 10|
|`echo {1,2}{a..e}`|1a 1b 1c 1d 1e 2a 2b 2c 2d 2e|
|`o="$(!!)"`|Rerun last command and capture output eg. `which f.txt`, `o="$(!!)"`, `vi "$o"`|


### claude

|||
|---|---|
|Quick/simple → Haiku; Everything else → Sonnet; Hard problems → Opus||


### code

|||
|---|---|
|ALT+z - Enable word wrap||
|CTRL+, - Open Settings||
|CTRL+. - Fix problem||
|CTRL+; - Find next problem (I added this shortcut)||
|CTRL+k CTRL+s - Open Keyboard Shortcuts||
|CTRL-k v - View markdown and markdown preview side by side||


### column

|||
|---|---|
|`column -J -s"," -N col1,col2`|format csv as JSON with attribute names col1, col2|
|`column -t -s"," -N col1,col2`|format csv as a table with headings col1, col2|


### find

|||
|---|---|
|`find . -name "*.jar" -exec du -h {} \;`|Find the size of jar files|
|`find . -type d -name ".git"`|Find directories|
|`find . -type d -name .git -prune -o -type f -name *.py -print`|exclude .git directories|
|`find . -type f -mtime +90`|Find files last modified at least 90 days ago|


### gcp

|||
|---|---|
|gcloud auth login --no-launch-browser||


### git

|||
|---|---|
|`git checkout tags/<tag name>`|checkout a git tag.|
|`git push --set-upstream origin main`|set main as default origin branch|


### grep

|||
|---|---|
|`grep -v ...`|to invert the match|


### if

|||
|---|---|
|`if [[ -n "$var" ]]`|Non-zero length / not empty check|
|`if [[ -z "$var" ]]`|Zero length / empty check|


### ln

|||
|---|---|
|`ln -s <target_file_or_dir> [<link_name>]`|-s symbolic link (ie a pointer), hard link is same item two names|


### postgres

|||
|---|---|
|`ALTER ROLE <username> SET search_path TO <schema name>;`|Permanently alter search_path.|
|`SET search_path TO <schema name>;`|Alter the schema searched.|
|`SHOW search_path;`|show the currently search schema.|
|`export PGPASSWORD=postgres`|Set password|
|`export PGPASSWORD=postgres; cat my.sql \| psql -h localhost -U postgres -d postgres`|Run my.sql|


### ps

|||
|---|---|
|`ps auxww`|list linux processes, ww - show full command, do not truncate|


### psql

|||
|---|---|
|`SET search_path=<schema>[,<schema>];`|set current schema(s)|
|`SHOW search_path;`|show current schema(s)|
|`\c <db>`|connect to database|
|`\d <table>`|describe table|
|`\dn`|list schemas|
|`\dt`|list tables|
|`\l`|list databases|


### sed

|||
|---|---|
|`sed -E`|Extended - can use 's/a+/b/' rather than 's/a\+/b/'|
|`sed -E 's/a+/b/'`|one or more a's.|
|`sed -E 's/a{2,5}/b/'`|between 2 and 5 a's|


### sort

|||
|---|---|
|`sort -h`|Sort human readable numbers eg 1.2GB, 9KB|


### tar

|||
|---|---|
|`tar -cvzf filename sourcedir`|Create tarball.|
|`tar -xvzf <filename>`|Extract zipped tarball.|


### tr

|||
|---|---|
|`tr A-Z a-z`|lowercase|
|`tr a-z A-Z`|uppercase|


### vim

|||
|---|---|
|`/lala\C`|Make search case sensitive (..\c - insensitive) [sed, regex]|
|`:%!sort -R`|Random order - calling external app to order [sed, regex]|
|`\a (\A)`|alphabetic character [A-Za-z]. Uppercase: non ... [sed, regex]|
|`\d \x (\D \X)`|digit [0-9], hex digit [0-9A-Fa-f]. Uppercase: non... [sed, regex]|
|`\l \u`|lowercase letter [a-z], uppercase letter [sed, regex]|
|`\w \s (\W \S)`|word character [0-9A-Za-z_], whitespace char (space, tab). Uppercase: non... [sed, regex]|


### wsl

|||
|---|---|
|`/c/Users/[name]/.wslconfig`|WSL Config|
