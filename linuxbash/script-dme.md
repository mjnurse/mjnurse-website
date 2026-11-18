---
title: dme: Linux system health
---

```bash
#!/usr/bin/env bash
help_text="
usage: dme [options] <filename>
-h : This help text.
"

help_line="Linux system health"
web_desc_line="Linux system health"

set -uo pipefail # Treat unset variables as an error and fail on pipe errors

case ${1:-} in
    -h|--help)
        echo "$help_text"
        exit
        ;;
esac

# secaudit.sh : a 30 second security check (run with sudo)
echo "Accounts with root power (UID 0):"
awk -F: '$3 == 0 {print "  " $1}' /etc/passwd
echo

echo "Users who can actually log in:"
grep -Ev 'nologin|false$' /etc/passwd | cut -d: -f1 | xargs | sed 's/^/  /'
echo

echo "Sudo group members:"
getent group sudo wheel | cut -d: -f4 | tr ',' ' ' | xargs | sed 's/^/  /'
echo

echo "Logged in right now:"
who
echo

echo "Last 5 logins:"
last -n 5 | head -n 5
echo

if [ -r /var/log/auth.log ]; then
  fails=$(grep -c "Failed password" /var/log/auth.log)
else
  fails=$(journalctl -q -u ssh -u sshd 2>/dev/null | grep -c "Failed password")
fi
echo "Failed SSH password attempts : $fails"
echo "Files in /etc changed today  : $(find /etc -type f -mtime -1 2>/dev/null | wc -l)"
```
