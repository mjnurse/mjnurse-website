---
title: Shrink WSL Virtual Disk
---

I noticed a very large (32GB) file:

```
C:\Users\...\AppData\Local\Docker\wsl\data\ext4.vhdx
```

Before doing anything it might be sensible to back the disk etc. up.

### 1. First check is WSL is running and if so ternimate it

Using Windows Powershell:

```
> wsl.exe --list --verbose
  NAME                   STATE           VERSION
* Ubuntu                 Running         1
  docker-desktop-data    Running         2
  docker-desktop         Running         2
```

Terminate the running WSL(s):

```
> wsl.exe --terminate Ubuntu
```

### 2. Use diskpart to shrink the disk partition

Using Windows Powershell:

```
DISKPART> select vdisk file="C:\Users\...\LocalState\ext4.vhdx"

DiskPart successfully selected the virtual disk file.

DISKPART> compact vdisk

100 percent completed

DiskPart successfully compacted the virtual disk file.	
```

<hr>
