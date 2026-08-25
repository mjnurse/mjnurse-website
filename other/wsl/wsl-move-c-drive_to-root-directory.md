---
title: WSL Move C Drive to Root Directory
---

`sudo mkdir -p /c` 

Update /etc/fstab; requires su.

`sudo sh -c "echo '/mnt/c /c none bind' >> /etc/fstab"`

Reload fstab; requires su.

`sudo mount -a`
<hr>
