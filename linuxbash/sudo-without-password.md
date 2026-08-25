---
title: sudo Without Password
---

To stop being prompted for a password when running `sudo` commands.

Open the sudoers file whist ensuring you don’t lock yourself out due to syntax errors:

```bash
sudo visudo
```

Add the following rule for Your user (add this line at the end of the file):

```bash
<username> ALL=(ALL) NOPASSWD: ALL
```

eg.

```bash
martin ALL=(ALL) NOPASSWD: ALL
```
