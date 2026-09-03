# Miscellaneous Notes

The notes captured in the Linux notes tool = `n`.

### 7zip

<table>
<tr><td><code>7z a -p -mhe=on archive.7z <files_or_folders></code></td><td>-mhe=on - encrypt file contents and filenames/headers.</td></tr>
</table>

### ES

<table>
<tr><td><code>@esql 'SELECT id.value FROM "mdm-example-entity-store-business-all-data"'</code></td><td>Elasticsearch SQL</td></tr>
</table>

### Excel

<table>
<tr><td>Open Drop-down in Cell - ALT-DOWN_ARROW</td></tr>
</table>

### Windows

<table>
<tr><td>WIN-H - turn on dictation</td></tr>
</table>

### apt

<table>
<tr><td><code>sudo apt autoclean</code></td><td>tidy the package cache</td></tr>
<tr><td><code>sudo apt autoremove</code></td><td>remove not required dependencies</td></tr>
<tr><td><code>sudo apt install ./download/apt.deb</code></td><td>install deb files</td></tr>
</table>

### awk

<table>
<tr><td><code>cmd \|\| awk '{print $1, $3}'</code></td><td>print 1st and 3rd space separated columns</td></tr>
</table>

### bash

<table>
<tr><td><code>!! !<abc> !!:p !<abc>:p</code></td><td>Run last command (:p - print command)</td></tr>
<tr><td><code>!^ !$ !:2 !:2-4</code></td><td>First, Last, 2nd, 2nd to 4th arguments from prev command (!:0 is last command)</td></tr>
<tr><td><code>#!/usr/bin/env bash</code></td><td>First line bash script</td></tr>
<tr><td><code>cp file.txt{,.bak}</code></td><td>cp file.txt file.txt.bak</td></tr>
<tr><td><code>echo {0..10..2}</code></td><td>0 -> 10 in steps of 2: 0 2 4 6 8 10</td></tr>
<tr><td><code>echo {1,2}{a..e}</code></td><td>1a 1b 1c 1d 1e 2a 2b 2c 2d 2e</td></tr>
<tr><td><code>o="$(!!)"</code></td><td>Rerun last command and capture output eg. `which f.txt`, `o="$(!!)"`, `vi "$o"`</td></tr>
</table>

### claude

<table>
<tr><td>Quick/simple → Haiku; Everything else → Sonnet; Hard problems → Opus</td></tr>
</table>

### code

<table>
<tr><td>ALT+z - Enable word wrap</td></tr>
<tr><td>CTRL+, - Open Settings</td></tr>
<tr><td>CTRL+. - Fix problem</td></tr>
<tr><td>CTRL+; - Find next problem (I added this shortcut)</td></tr>
<tr><td>CTRL+k CTRL+s - Open Keyboard Shortcuts</td></tr>
<tr><td>CTRL-k v - View markdown and markdown preview side by side</td></tr>
</table>

### column

<table>
<tr><td><code>column -J -s"," -N col1,col2</code></td><td>format csv as JSON with attribute names col1, col2</td></tr>
<tr><td><code>column -t -s"," -N col1,col2</code></td><td>format csv as a table with headings col1, col2</td></tr>
</table>

### find

<table>
<tr><td><code>find . -name "*.jar" -exec du -h {} \;</code></td><td>Find the size of jar files</td></tr>
<tr><td><code>find . -type d -name ".git"</code></td><td>Find directories</td></tr>
<tr><td><code>find . -type d -name .git -prune -o -type f -name *.py -print</code></td><td>exclude .git directories</td></tr>
<tr><td><code>find . -type f -mtime +90</code></td><td>Find files last modified at least 90 days ago</td></tr>
</table>

### gcp

<table>
<tr><td>gcloud auth login --no-launch-browser</td></tr>
</table>

### git

<table>
<tr><td><code>git checkout tags/<tag name></code></td><td>checkout a git tag.</td></tr>
<tr><td><code>git push --set-upstream origin main</code></td><td>set main as default origin branch</td></tr>
</table>

### grep

<table>
<tr><td><code>grep -v ...</code></td><td>to invert the match</td></tr>
</table>

### if

<table>
<tr><td><code>if [[ -n "$var" ]]</code></td><td>Non-zero length / not empty check</td></tr>
<tr><td><code>if [[ -z "$var" ]]</code></td><td>Zero length / empty check</td></tr>
</table>

### jq

<table>
<tr><td><code>jq '. \| length'</code></td><td>Count</td></tr>
<tr><td><code>jq '.[0]'</code></td><td>Array item</td></tr>
<tr><td><code>jq '.[] \| select(x == "y")'</code></td><td>Filter</td></tr>
<tr><td><code>jq '.[] \| {a, b}'</code></td><td>Pick fields</td></tr>
<tr><td><code>jq '.[]'</code></td><td>Loop array</td></tr>
<tr><td><code>jq '.a.b.c'</code></td><td>Nested field</td></tr>
<tr><td><code>jq '.field'</code></td><td>Get a field</td></tr>
<tr><td><code>jq -r '.field'</code></td><td>Raw output </td></tr>
</table>

### ln

<table>
<tr><td><code>ln -s <target_file_or_dir> [<link_name>]</code></td><td>-s symbolic link (ie a pointer), hard link is same item two names</td></tr>
</table>

### postgres

<table>
<tr><td><code>ALTER ROLE <username> SET search_path TO <schema name>;</code></td><td>Permanently alter search_path.</td></tr>
<tr><td><code>SET search_path TO <schema name>;</code></td><td>Alter the schema searched.</td></tr>
<tr><td><code>SHOW search_path;</code></td><td>show the currently search schema.</td></tr>
<tr><td><code>export PGPASSWORD=postgres</code></td><td>Set password</td></tr>
<tr><td><code>export PGPASSWORD=postgres; cat my.sql \| psql -h localhost -U postgres -d postgres</code></td><td>Run my.sql</td></tr>
</table>

### ps

<table>
<tr><td><code>ps auxww</code></td><td>list linux processes, ww - show full command, do not truncate</td></tr>
</table>

### psql

<table>
<tr><td><code>SET search_path=<schema>[,<schema>];</code></td><td>set current schema(s)</td></tr>
<tr><td><code>SHOW search_path;</code></td><td>show current schema(s)</td></tr>
<tr><td><code>\c <db></code></td><td>connect to database</td></tr>
<tr><td><code>\d <table></code></td><td>describe table</td></tr>
<tr><td><code>\dn</code></td><td>list schemas</td></tr>
<tr><td><code>\dt</code></td><td>list tables</td></tr>
<tr><td><code>\l</code></td><td>list databases</td></tr>
</table>

### sed

<table>
<tr><td><code>sed -E</code></td><td>Extended - can use 's/a+/b/' rather than 's/a\+/b/'</td></tr>
<tr><td><code>sed -E 's/a+/b/'</code></td><td>one or more a's.</td></tr>
<tr><td><code>sed -E 's/a{2,5}/b/'</code></td><td>between 2 and 5 a's</td></tr>
</table>

### sort

<table>
<tr><td><code>sort -h</code></td><td>Sort human readable numbers eg 1.2GB, 9KB</td></tr>
</table>

### sqlite

<table>
<tr><td><code>REPLACE(PRINTF('%100c', ' '), ' ', 'X')</code></td><td>Generate a string of 100 X's</td></tr>
</table>

### tar

<table>
<tr><td><code>tar -cvzf filename sourcedir</code></td><td>Create tarball.</td></tr>
<tr><td><code>tar -xvzf <filename></code></td><td>Extract zipped tarball.</td></tr>
</table>

### tr

<table>
<tr><td><code>tr A-Z a-z</code></td><td>lowercase</td></tr>
<tr><td><code>tr a-z A-Z</code></td><td>uppercase</td></tr>
</table>

### vim

<table>
<tr><td><code>/lala\C</code></td><td>Make search case sensitive (..\c - insensitive) [sed, regex]</td></tr>
<tr><td><code>:%!sort -R</code></td><td>Random order - calling external app to order [sed, regex]</td></tr>
<tr><td><code>\a (\A)</code></td><td>alphabetic character [A-Za-z]. Uppercase: non ... [sed, regex]</td></tr>
<tr><td><code>\d \x (\D \X)</code></td><td>digit [0-9], hex digit [0-9A-Fa-f]. Uppercase: non... [sed, regex]</td></tr>
<tr><td><code>\l \u</code></td><td>lowercase letter [a-z], uppercase letter [sed, regex]</td></tr>
<tr><td><code>\w \s (\W \S)</code></td><td>word character [0-9A-Za-z_], whitespace char (space, tab). Uppercase: non... [sed, regex]</td></tr>
</table>

### wsl

<table>
<tr><td><code>/c/Users/[name]/.wslconfig</code></td><td>WSL Config</td></tr>
</table>
