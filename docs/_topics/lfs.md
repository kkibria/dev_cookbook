---
title: Linux from scratch
---
# {{ page.title }}

## LFS with wsl2
Get the [LFS book](http://www.linuxfromscratch.org/lfs/download.html). This book provides step by step guide to build an LFS system. Following will provide steps for chapter 1 & 2.

We will be needing few packages that we will install if they are not installed,
```bash
sudo apt-get install subversion xsltproc
```

run setup.sh which will create ``sourceMe.sh`` in the current folder. It will also download the book source to create other scripts and files.
```bash
sh /mnt/c/Users/<user>/Documents/linux/LFS/lfs-scripts/setup.sh
```

Now source ``sourceMe.sh`` to mount the scripts
```bash
$ source sourceMe.sh
Mounting /mnt/c/Users/<user>/Documents/linux/LFS/lfs-scripts on lfs-scripts
umount: lfs-scripts: not mounted.
sh: mount-lfs.sh: No such file or directory
```

Check the requirements for LFS,
```bash
sh lfs-scripts/version-check.sh
```

Change shell to bash from dash if necessary,
```bash
sh lfs-scripts/ch2bash.sh
```

Let us create an empty disk image with two partitions,
```bash
sh lfs-scripts/mkdiscimg.sh
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

Now source ``sourceMe.sh`` the second time to mount the image.

From now on, you can source ``sourceMe.sh`` before you start working to have everything setup after you boot between steps if necessary.

We are ready to go with chapter 3. 

When we ran ``setup.sh``, it downloaded the book and created,
* ``packages.sh``
* ``patches.sh``
* ``wget-list``
* ``md5sums``
Feel free to examine them.

Lets proceed to download the sources,
```bash
sudo mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/sources
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
cp md5sums $LFS/sources
pushd $LFS/sources
md5sum -c md5sums
popd
``` 
Note that if a download fails you have to find an alternate source by googling and then adjust ``wget-list``.
> Writing a makefile using ``packages.sh`` and ``patches.sh`` could be an alternative.

We are ready to go with chapter 4. Follow chapter 4 instructions from the book.

In chapter 5, prepare ``lib`` folders and go to ``sources`` folder, 
```bash
case $(uname -m) in
 x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac
cd $LFS/sources
```

### Build pass 1 binutils,
```bash
tar -xvf binutils-2.34.tar.xz
pushd binutils-2.34

mkdir -v build
cd build

../config.guess
../configure --prefix=/tools \
 --with-sysroot=$LFS \
 --with-lib-path=/tools/lib \
 --target=$LFS_TGT \
 --disable-nls \
 --disable-werror

make
make install

# if everything went fine we can remove
popd
rm -rf binutils-2.34
```

### build pass 1 gcc,
```bash
tar -xvf gcc-9.2.0.tar.xz
pushd gcc-9.2.0

tar -xf ../mpfr-4.0.2.tar.xz
mv -v mpfr-4.0.2 mpfr
tar -xf ../gmp-6.2.0.tar.xz
mv -v gmp-6.2.0 gmp
tar -xf ../mpc-1.1.0.tar.gz
mv -v mpc-1.1.0 mpc

for file in gcc/config/{linux,i386/linux{,64}}.h
do
 cp -uv $file{,.orig}
 sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
 -e 's@/usr@/tools@g' $file.orig > $file
 echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
 touch $file.orig
done

case $(uname -m) in
 x86_64)
 sed -e '/m64=/s/lib64/lib/' \
 -i.orig gcc/config/i386/t-linux64
 ;;
esac

mkdir -v build
cd build

../configure \
 --target=$LFS_TGT \
 --prefix=/tools \
 --with-glibc-version=2.11 \
 --with-sysroot=$LFS \
 --with-newlib \
 --without-headers \
 --with-local-prefix=/tools \
 --with-native-system-header-dir=/tools/include \
 --disable-nls \
 --disable-shared \
 --disable-multilib \
 --disable-decimal-float \
 --disable-threads \
 --disable-libatomic \
 --disable-libgomp \
 --disable-libquadmath \
 --disable-libssp \
 --disable-libvtv \
 --disable-libstdcxx \
 --enable-languages=c,c++

# take a cup of coffee and relax
make
make install

popd
rm -rf gcc-9.2.0
```

### Install linux headers 
```bash
tar -xvf linux-5.5.3.tar.xz
pushd linux-5.5.3

make mrproper
make headers
cp -rv usr/include/* /tools/include

popd
rm -rf linux-5.5.3
```

### Build Glibc
```bash
tar -xvf glibc-2.31.tar.xz
pushd glibc-2.31

mkdir -v build
cd build

../configure \
 --prefix=/tools \
 --host=$LFS_TGT \
 --build=$(../scripts/config.guess) \
 --enable-kernel=3.2 \
 --with-headers=/tools/include

make
make install

popd
rm -rf glibc-2.31
```

Test the build,
```bash
mkdir test
pushd test
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'
popd
rm -rf test
```
This should produce output,
```text
[Requesting program interpreter: /tools/lib64/ld-linux-x86-64.so.2]
```
Note that for 32-bit machines, the interpreter name will be /tools/lib/ld-linux.so.2.

### Build Libstdc++
```bash
tar -xvf gcc-9.2.0.tar.xz
pushd gcc-9.2.0
mkdir -v build
cd build

../libstdc++-v3/configure \
 --host=$LFS_TGT \
 --prefix=/tools \
 --disable-multilib \
 --disable-nls \
 --disable-libstdcxx-threads \
 --disable-libstdcxx-pch \
 --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/9.2.0

make
make install

popd
rm -rf gcc-9.2.0
```

### Build pass 2 binutils,
```bash
tar -xvf binutils-2.34.tar.xz
pushd binutils-2.34

mkdir -v build
cd build

CC=$LFS_TGT-gcc \
AR=$LFS_TGT-ar \
RANLIB=$LFS_TGT-ranlib \
../configure \
 --prefix=/tools \
 --disable-nls \
 --disable-werror \
 --with-lib-path=/tools/lib \
 --with-sysroot

make
make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

popd
rm -rf binutils-2.34
```






## Projects using LFS
* [Linux From scratch build scripts](https://github.com/jfdelnero/LinuxFromScratch)