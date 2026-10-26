---
title: n: Record and query notes
---

## Demo

<pre style='background: black; color: white; margin-top: 20px;'>
$ n vim
<span style="color:olive;"> _  _     _
| \| |___| |_ ___ ___
| .` / _ \  _/ -_|_-&lt;
|_|\_\___/\__\___/__/</span>

<span style="color:teal;"></span><span style="color:green;">vim</span>: /lala\C <span style="color:purple;"># Make search case sensitive (..\c - insensitive) [sed, regex]</span>
<span style="color:teal;"></span><span style="color:green;">vim</span>: :%!sort -R <span style="color:purple;"># Random order - calling external app to order [sed, regex]</span>
<span style="color:teal;"></span><span style="color:green;">vim</span>: \a (\A) <span style="color:purple;"># alphabetic character [A-Za-z]. Uppercase: non ... [sed, regex]</span>
<span style="color:teal;"></span><span style="color:green;">vim</span>: \d \x (\D \X) <span style="color:purple;"># digit [0-9], hex digit [0-9A-Fa-f]. Uppercase: non... [sed, regex]</span>
<span style="color:teal;"></span><span style="color:green;">vim</span>: \l \u <span style="color:purple;"># lowercase letter [a-z], uppercase letter [sed, regex]</span>
<span style="color:teal;"></span><span style="color:green;">vim</span>: \w \s (\W \S) <span style="color:purple;"># word character [0-9A-Za-z_], whitespace char (space, tab). Uppercase: non... [sed, regex]</span>
<span style="color:teal;"></span><span style="color:green;">vim</span>: s/de/la&amp;da/ <span style="color:purple;"># &amp; in replacement is the matched text</span>
$ 
$ n wi
<span style="color:olive;"> _  _     _
| \| |___| |_ ___ ___
| .` / _ \  _/ -_|_-&lt;
|_|\_\___/\__\___/__/</span>

<span style="color:teal;"></span><span style="color:green;">Wi</span>ndows: <span style="color:green;">WI</span>N-H - turn on dictation
<span style="color:teal;">column:</span> column -J -s&quot;,&quot; -N col1,col2 <span style="color:purple;"># format csv as JSON </span><span style="color:green;">wi</span><span style="color:purple;">th attribute names col1, col2</span>
<span style="color:teal;">column:</span> column -t -s&quot;,&quot; -N col1,col2 <span style="color:purple;"># format csv as a table </span><span style="color:green;">wi</span><span style="color:purple;">th headings col1, col2</span>
$ 
</pre>


## Script

```bash
#!/usr/bin/env bash
help_text="
NAME
  n - Notes

USAGE
  n [options] [<text - consider wrapping in quotes> <text2> <text3>]

OPTIONS
  -h|--help
    Show this help message.

  -a|--add
    Add the <text> as a new note.

  -e|--edit
    Edit the notes text file.

  -m|--markdown
    Generate a markdown version of the notes file.

DESCRIPTION
  Record and query notes.

  Any note which contains the text "[P]" is a Private note. Private notes are not 
  included in the markdown extract.

AUTHOR
  mjnurse.github.io - 2026
"

help_line="Record and query notes"
web_desc_line="Record and query notes"

# Terminal Colours
cdef=$'\e[39m' # default colour
cbla=$'\e[30m'; cgra=$'\e[90m'; clgra=$'\e[37m'; cwhi=$'\e[97m'
cred=$'\e[31m'; cgre=$'\e[32m'; cyel=$'\e[33m'; cblu=$'\e[34m'; cmag=$'\e[35m'; ccya=$'\e[36m';
clred=$'\e[91m'; clgre=$'\e[92m'; clyel=$'\e[93m'; clblu=$'\e[94m'; clmag=$'\e[95m'; clcya=$'\e[96m'

nf=~/.notes.txt

function display_notes() {
  w1="${1:-dummydummydummy}"
  w2="${2:-$w1}"; w3="${3:-$w1}"; w4="${4:-$w1}"; w5="${5:-$w1}"
  if [[ "$w1" == "dummydummydummy" ]]; then
    notes="$(cat "$nf")"
  else
    if [[ ${#w1} -lt 2 || ${#w2} -lt 2 || ${#w3} -lt 2 || ${#w4} -lt 2 || ${#w5} -lt 2 ]]; then
      echo "Error: Search terms must be at least 2 characters long."
      return
    fi
    notes="$(cat "$nf" | grep --ignore-case "$w1" | grep --ignore-case "$w2" | grep --ignore-case "$w3" | grep --ignore-case "$w4" | grep --ignore-case "$w5")"
  fi
  echo -e $cyel' _  _     _'
  echo -e      '| \| |___| |_ ___ ___'
  echo -e      '| .` / _ \  _/ -_|_-<'
  echo -e      '|_|\_\___/\__\___/__/'$cdef
  echo
  echo "$notes" | sed "
    s/^\(\w*:\)/CCYA\1CDEF/; 
    s/\(${w1}\)/CGRE\1CDEF/Ig;
    s/\(${w2}\)/CGRE\1CDEF/Ig;
    s/\(${w3}\)/CGRE\1CDEF/Ig;
    s/\(${w4}\)/CGRE\1CDEF/Ig;
    s/\(${w5}\)/CGRE\1CDEF/Ig;
    s/\(# .*\)/CMAG\1CDEF/I;
    s/\(.*\)\[P\] *\(.*\)/CGRE\[P\]CCYA \1\2/;
    :a; s/\(# .*\)CDEF/\1CMAG/; ta;
    s/$/CDEF/;
    s/CCYA/${clcya}/g; s/CGRE/${clgre}/g; s/CMAG/${clmag}/g; s/CDEF/${cdef}/g
  "
}

if [[ "$1" == "" ]]; then
  display_notes
  echo
  echo "Usage: n [options] [<text - consider wrapping in quotes> <text2> <text3>]"
  echo "Try:  \"n -h\" for more information."
  exit
fi

case ${1-} in
  -a|--add)
    shift
    echo "$*" >> "$nf"
    ;;
  -e|--edit)
    vi "$nf"
    ;;
  -m|--markdown)
    # Generate a markdown version of the notes file
    echo "# Miscellaneous Notes"
    echo
    echo "The notes captured in the Linux notes tool = \`n\`."
    echo
    cat "$nf" \
    | sed '1s/^/\n/;
           /\[P\]/d;
           s/|/###BAR###/g;
           s/</\&lt;/g;
           s/>/\&gt;/g;
          ' \
    | sed '/^$/{N;/^\n$/D;}' \
    | sed '/^$/{ N; 
           s/\n\([^ \t][^ \t]*\)/<\/table>\n\n### \1\n\n<table>\n\1/ }' \
    | sed '1,2d;
           s/^\(###.*\):/\1/;
           s/^[^:]\+: *//;
           s/^\(.*\) # \(.*\)$/<tr><td><code>\1<\/code><\/td><td>\2<\/td><\/tr>/;
           s/^\([^|#<].*\)$/<tr><td>\1<\/td><\/tr>/;
           $s/$/\n<\/table>/;
           s/###BAR###/\\|/g;
          '
    ;;
  -h|--help)
    echo "$help_text"
    exit
    ;;
  *)
    display_notes "$1" "$2" "$3"
    exit
    ;;
esac

sort "$nf" | sed '/^$/d' > "$nf".tmp

# Group lines by their first word, inserting a blank line whenever the first word changes.
awk '
    {
        split($0, words, " ")
        if (NR == 1) {
            prev = words[1]
            print
        } else {
            if (words[1] != prev) {
            print ""
            prev = words[1]
            }
            print
        }
    }' "$nf".tmp > "$nf"
rm -f "$nf".tmp

```
