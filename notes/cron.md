---
title: CRON
---

## Format of crontab:

First five fields are: 

```
<minutes:0-59> <hours:0-23> <day-of-month:1-31> <month:1-12> <day-of-week:0-6:0=Sunday>
```

Command: `sudo crontab -e`

Alternatively:

```
echo "* 12 * * * /usr/local/bin/script" >> /var/spool/cron/root
```
<hr>
