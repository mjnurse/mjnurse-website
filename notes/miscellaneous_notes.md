# Miscellaneous Notes

The notes captured in the Linux notes tool = `n`.

### 7zip

<table>
<tr><td>`7z a -p -mhe=on archive.7z <files_or_folders>`</td><td>-mhe=on - encrypt file contents and filenames/headers.</td></tr>
</table>

### ES

<table>
<tr><td>`@esql 'SELECT id.value FROM "mdm-example-entity-store-business-all-data"'`</td><td>Elasticsearch SQL</td></tr>
</table>

### Excel

<table>
Open Drop-down in Cell - ALT-DOWN_ARROW
</table>

### Windows

<table>
WIN-H - turn on dictation
</table>

### apt

<table>
<tr><td>`sudo apt autoclean`</td><td>tidy the package cache</td></tr>
<tr><td>`sudo apt autoremove`</td><td>remove not required dependencies</td></tr>
<tr><td>`sudo apt install ./download/apt.deb`</td><td>install deb files</td></tr>
</table>

### awk

<table>
<tr><td>`cmd \|\| awk '{print $1, $3}'`</td><td>print 1st and 3rd space separated columns</td></tr>
</table>

### bash

<table>
<tr><td>`!! !<abc> !!:p !<abc>:p`</td><td>Run last command (:p - print command)</td></tr>
<tr><td>`!^ !$ !:2 !:2-4`</td><td>First, Last, 2nd, 2nd to 4th arguments from prev command (!:0 is last command)</td></tr>
<tr><td>`#!/usr/bin/env bash`</td><td>First line bash script</td></tr>
<tr><td>`cp file.txt{,.bak}`</td><td>cp file.txt file.txt.bak</td></tr>
<tr><td>`echo {0..10..2}`</td><td>0 -> 10 in steps of 2: 0 2 4 6 8 10</td></tr>
<tr><td>`echo {1,2}{a..e}`</td><td>1a 1b 1c 1d 1e 2a 2b 2c 2d 2e</td></tr>
<tr><td>`o="$(!!)"`</td><td>Rerun last command and capture output eg. `which f.txt`, `o="$(!!)"`, `vi "$o"`</td></tr>
</table>

### claude

<table>
Quick/simple → Haiku; Everything else → Sonnet; Hard problems → Opus
</table>

### code

<table>
ALT+z - Enable word wrap
CTRL+, - Open Settings
CTRL+. - Fix problem
CTRL+; - Find next problem (I added this shortcut)
CTRL+k CTRL+s - Open Keyboard Shortcuts
CTRL-k v - View markdown and markdown preview side by side
</table>

### column

<table>
<tr><td>`column -J -s"," -N col1,col2`</td><td>format csv as JSON with attribute names col1, col2</td></tr>
<tr><td>`column -t -s"," -N col1,col2`</td><td>format csv as a table with headings col1, col2</td></tr>
</table>

### find

<table>
<tr><td>`find . -name "*.jar" -exec du -h {} \;`</td><td>Find the size of jar files</td></tr>
<tr><td>`find . -type d -name ".git"`</td><td>Find directories</td></tr>
<tr><td>`find . -type d -name .git -prune -o -type f -name *.py -print`</td><td>exclude .git directories</td></tr>
<tr><td>`find . -type f -mtime +90`</td><td>Find files last modified at least 90 days ago</td></tr>
</table>

### gcp

<table>
gcloud auth login --no-launch-browser
</table>

### git

<table>
<tr><td>`git checkout tags/<tag name>`</td><td>checkout a git tag.</td></tr>
<tr><td>`git push --set-upstream origin main`</td><td>set main as default origin branch</td></tr>
</table>

### grep

<table>
<tr><td>`grep -v ...`</td><td>to invert the match</td></tr>
</table>

### if

<table>
<tr><td>`if [[ -n "$var" ]]`</td><td>Non-zero length / not empty check</td></tr>
<tr><td>`if [[ -z "$var" ]]`</td><td>Zero length / empty check</td></tr>
</table>

### jq

<table>
<tr><td>`jq '. \| length'`</td><td>Count</td></tr>
<tr><td>`jq '.[0]'`</td><td>Array item</td></tr>
<tr><td>`jq '.[] \| select(x == "y")'`</td><td>Filter</td></tr>
<tr><td>`jq '.[] \| {a, b}'`</td><td>Pick fields</td></tr>
<tr><td>`jq '.[]'`</td><td>Loop array</td></tr>
<tr><td>`jq '.a.b.c'`</td><td>Nested field</td></tr>
<tr><td>`jq '.field'`</td><td>Get a field</td></tr>
<tr><td>`jq -r '.field'`</td><td>Raw output </td></tr>
</table>

### ln

<table>
<tr><td>`ln -s <target_file_or_dir> [<link_name>]`</td><td>-s symbolic link (ie a pointer), hard link is same item two names</td></tr>
</table>

### postgres

<table>
<tr><td>`ALTER ROLE <username> SET search_path TO <schema name>;`</td><td>Permanently alter search_path.</td></tr>
<tr><td>`SET search_path TO <schema name>;`</td><td>Alter the schema searched.</td></tr>
<tr><td>`SHOW search_path;`</td><td>show the currently search schema.</td></tr>
<tr><td>`export PGPASSWORD=postgres`</td><td>Set password</td></tr>
<tr><td>`export PGPASSWORD=postgres; cat my.sql \| psql -h localhost -U postgres -d postgres`</td><td>Run my.sql</td></tr>
</table>

### ps

<table>
<tr><td>`ps auxww`</td><td>list linux processes, ww - show full command, do not truncate</td></tr>
</table>

### psql

<table>
<tr><td>`SET search_path=<schema>[,<schema>];`</td><td>set current schema(s)</td></tr>
<tr><td>`SHOW search_path;`</td><td>show current schema(s)</td></tr>
<tr><td>`\c <db>`</td><td>connect to database</td></tr>
<tr><td>`\d <table>`</td><td>describe table</td></tr>
<tr><td>`\dn`</td><td>list schemas</td></tr>
<tr><td>`\dt`</td><td>list tables</td></tr>
<tr><td>`\l`</td><td>list databases</td></tr>
</table>

### sed

<table>
<tr><td>`sed -E`</td><td>Extended - can use 's/a+/b/' rather than 's/a\+/b/'</td></tr>
<tr><td>`sed -E 's/a+/b/'`</td><td>one or more a's.</td></tr>
<tr><td>`sed -E 's/a{2,5}/b/'`</td><td>between 2 and 5 a's</td></tr>
</table>

### sort

<table>
<tr><td>`sort -h`</td><td>Sort human readable numbers eg 1.2GB, 9KB</td></tr>
</table>

### sqlite

<table>
<tr><td>`REPLACE(PRINTF('%100c', ' '), ' ', 'X')`</td><td>Generate a string of 100 X's</td></tr>
</table>

### tar

<table>
<tr><td>`tar -cvzf filename sourcedir`</td><td>Create tarball.</td></tr>
<tr><td>`tar -xvzf <filename>`</td><td>Extract zipped tarball.</td></tr>
</table>

### tr

<table>
<tr><td>`tr A-Z a-z`</td><td>lowercase</td></tr>
<tr><td>`tr a-z A-Z`</td><td>uppercase</td></tr>
</table>

### vim

<table>
<tr><td>`/lala\C`</td><td>Make search case sensitive (..\c - insensitive) [sed, regex]</td></tr>
<tr><td>`:%!sort -R`</td><td>Random order - calling external app to order [sed, regex]</td></tr>
<tr><td>`\a (\A)`</td><td>alphabetic character [A-Za-z]. Uppercase: non ... [sed, regex]</td></tr>
<tr><td>`\d \x (\D \X)`</td><td>digit [0-9], hex digit [0-9A-Fa-f]. Uppercase: non... [sed, regex]</td></tr>
<tr><td>`\l \u`</td><td>lowercase letter [a-z], uppercase letter [sed, regex]</td></tr>
<tr><td>`\w \s (\W \S)`</td><td>word character [0-9A-Za-z_], whitespace char (space, tab). Uppercase: non... [sed, regex]</td></tr>
</table>

### wsl

<table>
<tr><td>`/c/Users/[name]/.wslconfig`</td><td>WSL Config</td></tr>
</table>
