---
title: Create An Encrypted Linux Virtual Disk
contents-list: h1,h2
---

# Create An Empty File With Space Allocated

Create a (64MB) empty file with space allocated.

```bash
> dd if=/dev/urandom iflag=fullblock | dd of=./diskfile1 bs=1M count=64 iflag=fullblock
```

# Create a dm-crypt LUKS Container

```bash
> sudo cryptsetup -y luksFormat ./diskfile1

WARNING!
========
This will overwrite data on ./diskfile1 irrevocably.

Are you sure? (Type uppercase yes): YES
Enter passphrase for ./diskfile1:
Verify passphrase:
```

Check the file.

```bash
> file diskfile1

diskfile1: LUKS encrypted file, ver 2 [, , sha256] UUID: ef633564-8376-4a41-9412-6afc00dd056a
```

# Open the LUKS Container and Mount as a Linux Drive

```bash
> sudo cryptsetup luksOpen ./diskfile1 encryptedVolume1
Enter passphrase for ./diskfile1:
```

Check the device.

```bash
> ll /dev/mapper
total 0
drwxr-xr-x 2 root root       80 Oct 18 17:34 ./
drwxr-xr-x 8 root root     2760 Oct 18 17:34 ../
crw------- 1 root root  10, 236 Oct 13 16:45 control
brw-rw---- 1 root disk 252,   0 Oct 18 17:34 encryptedVolume1

> sudo cryptsetup -v status encryptedVolume1
/dev/mapper/encryptedVolume1 is active.
  type:    LUKS2
  cipher:  aes-xts-plain64
  keysize: 512 bits
  key location: keyring
  device:  /dev/loop0
  loop:    /c/MJN/dmcrypt/diskfile1
  sector size:  512
  offset:  32768 sectors
  size:    98304 sectors
  mode:    read/write
Command successful.
```

Create a file system on the device and mount as a drive.

```bash
> sudo mkfs.ext4 /dev/mapper/encryptedVolume1
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 12288 4k blocks and 12288 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

> sudo mkdir /mnt/encryptedVolume1

> sudo mount /dev/mapper/encryptedVolume1 /mnt/encryptedVolume1/

> df -h
Filesystem                    Size  Used Avail Use% Mounted on
/dev/sdb                      251G  3.0G  236G   2% /
tmpfs                         6.2G     0  6.2G   0% /mnt/wsl
tools                         477G  145G  333G  31% /init
none                          6.2G     0  6.2G   0% /dev
/dev/mapper/encryptedVolume1   43M   44K   40M   1% /mnt/encryptedVolume1
```

Navigate to the open drive.

```bash
> cd /mnt/encryptedVolume1/

> ll
total 24
drwxr-xr-x 3 root root  4096 Oct 18 17:36 ./
drwxr-xr-x 6 root root  4096 Oct 18 17:36 ../
drwx------ 2 root root 16384 Oct 18 17:36 lost+found/
```

Unmount and close the encrypted volume.

```bash
> sudo umount /mnt/encryptedVolume1

> sudo cryptsetup luksClose encryptedVolume1
```

