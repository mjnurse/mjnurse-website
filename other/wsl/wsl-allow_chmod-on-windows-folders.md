---
title: WSL Allow chmod On Windows Folders
---

Create or edit a file named `/etc/wsl.conf` and edit it to contain the following.  Note I also move the mount point of the windows C drive from `/mnt/c` to `/c`.

```bash
[automount]
enabled = true
root = /
options = "metadata,umask=22,fmask=11"
```

Reboot WSL

```cmd
wsl.exe --shutdown
```
<hr>
