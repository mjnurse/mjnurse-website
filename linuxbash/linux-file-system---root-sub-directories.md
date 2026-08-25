---
title: Linux File System - root sub-directories
contents-list: h1
---

## Essential System Directories

- `/bin` → symlink to `/usr/bin` - Essential user command binaries (ls, cat, cp, etc.)
- `/sbin` → symlink to `/usr/sbin` - Essential system binaries (mount, ifconfig, shutdown, etc.) typically for root
- `/lib` → symlink to `/usr/lib` - Essential shared libraries and kernel modules
- `/lib64` → symlink to `/usr/lib64` - 64-bit libraries

## Boot and System Configuration

- `/boot` - Boot loader files, kernel images, initramfs
- `/etc` - System-wide configuration files

## User and Runtime

- `/home` - User home directories
- `/root` - Root user's home directory
- `/tmp` - Temporary files, cleared on reboot
- `/run` - Runtime variable data (PIDs, sockets) since last boot

## Virtual/Special Filesystems

- `/dev` - Device files (hard drives, terminals, null, random, etc.)
- `/proc` - Virtual filesystem exposing kernel/process information
- `/sys` - Virtual filesystem for kernel/hardware information

## Optional/Variable Data

- `/usr` - User programs, libraries, documentation (largest directory tree)
- `/var` - Variable data (logs, databases, caches, mail spools)
- `/opt` - Optional third-party software packages
- `/srv` - Data served by the system (web, FTP, etc.)
- `/media` - Mount points for removable media (USB, CD-ROM)
- `/mnt` - Temporary mount points for filesystems

## WSL/System-Specific

- `/lost+found - Filesystem recovery directory (ext4 fsck)
- `/snap - Snap package system files
