---
title: 26-03-04 - Create Use and Delete Temp File
section: linuxbash
---

How have I only just learnt about `mktemp`? It's a great way to create a temporary file, and trap means that it is automatically cleaned up when the script exits.

```bash
tmpfile=$(mktemp)
trap 'rm -f "$tmpfile"' EXIT
```

