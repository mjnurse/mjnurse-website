---
title: record-shell - Record Shell Session - saving as HTML
---

```bash
#!/usr/bin/env bash
help_text="
usage: record [options] <filename>
-h : This help text.
"

help_line="Record Shell Session - saving as HTML"
web_desc_line="Record Shell Session - saving as HTML"

case $1 in
    -h|--help)
        echo "$help_text"
        exit
        ;;
esac

if [[ "$1" == "" ]]; then
    echo "$help_text"
    exit 1
fi

script --log-out=/tmp/record.log -c 'PS1="$ "; export PS1; exec bash --norc -i'

sed -i '
    /^Script started/d
    /^Script done/d
    s/\r//g
' /tmp/record.log

sed -i -e '/./,$!d' -e ':a' -e '/./!{$d;N;ba}' /tmp/record.log

sed -i '${/^exit$/d;}' /tmp/record.log

aha < /tmp/record.log | sed -n "/<pre>/,/<\/pre>/p" | sed "s/^<pre>$/<pre style='background: black; color: white;'>/" > $1.html
# rm -f /tmp/record.log

echo "File created: $1.html"
```
