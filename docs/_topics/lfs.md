---
title: Linux from scratch
---
# {{ page.title }}

## LFS with wsl2
Get the [LFS book](http://www.linuxfromscratch.org/lfs/download.html). This book provides step by step guide to build an LFS system. Following will provide steps for chapter 1 & 2.

run setup.sh which will create ``sourceMe.sh`` in the current folder.
```bash
sh /mnt/c/Users/<user>/Documents/linux/LFS/lfs-scripts/setup.sh
```
From now on run ``source sourceMe.sh`` to make the scripts available.

Check the requirements for LFS,
```bash
version-check.sh
```

Change shell to bash from dash if necessary,
```bash
ch2bash.sh
```

Let us create an empty disk image with two partitions,
```bash
mkdiscimg.sh
```
This will create ``lfs.img`` with two partitions and a script ``mount-lfs.sh`` to mount the image. Check the image, 
```bash
$ fdisk -lu lfs.img
Disk lfs.img: 10.26 GiB, 11010048000 bytes, 21504000 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x0e0d22a7

Device     Boot  Start      End  Sectors  Size Id Type
lfs.img1          8192   532479   524288  256M  c W95 FAT32 (LBA)
lfs.img2        532480 21503999 20971520   10G 83 Linux
```

From now on run ``mount-lfs.sh`` to mount the image.

We are ready to go with chapter 3.
