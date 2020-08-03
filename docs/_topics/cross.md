---
title: Cross Compilation
---
# {{ page.title }}

## cross compile
[Anatomy of Cross-Compilation Toolchains](https://youtu.be/Pbt330zuNPc). The [slides](https://elinux.org/images/1/15/Anatomy_of_Cross-Compilation_Toolchains.pdf).

## Using rust in Raspberry pi
* [Cross Compiling Rust for the Raspberry Pi](https://chacin.dev/blog/cross-compiling-rust-for-the-raspberry-pi/)
* [Prebuilt Windows Toolchain for Raspberry Pi](https://gnutoolchains.com/raspberry/). Question: who are these people? where are the sources fro these tools?
* [Cross compiling Rust for ARM (e.g. Raspberry Pi) using any OS!](https://medium.com/@wizofe/cross-compiling-rust-for-arm-e-g-raspberry-pi-using-any-os-11711ebfc52b)
* [“Zero setup” cross compilation and “cross testing” of Rust crates](https://github.com/rust-embedded/cross)
* [Vagrant, Virtual machine for cross development](https://www.vagrantup.com/). I really like this setup, easy to use. Plays well with virtualbox.
* <https://github.com/kunerd/clerk/wiki/How-to-use-HD44780-LCD-from-Rust#setting-up-the-cross-toolchain>
* <https://opensource.com/article/19/3/physical-computing-rust-raspberry-pi>
* <https://github.com/japaric/rust-cross>

### QEMU for library dependencies
* [Debootstrap](http://linux-sunxi.org/Debootstrap)
* [Introduction to qemu-debootstrap](http://logan.tw/posts/2017/01/21/introduction-to-qemu-debootstrap/).
* <https://headmelted.com/using-qemu-to-produce-debian-filesystems-for-multiple-architectures-280df41d28eb>.
* [Kernel Recipes 2015 - Speed up your kernel development cycle with QEMU - Stefan Hajnoczi](https://youtu.be/PBY9l97-lto).
* [Debootstrap #1 Creating a Filesystem for Debian install Linux tutorial](https://youtu.be/L_r3z3402do).
* [Creating Ubuntu and Debian container base images, the old and simple way](https://youtu.be/OLFH4Ov6bJQ).
* [Raspberry Pi Emulator for Windows 10 Full Setup Tutorial and Speed Optimization](https://youtu.be/xiQX0YXYuqU).
* [RASPBERRY PI ON QEMU](https://azeria-labs.com/emulate-raspberry-pi-with-qemu/).
* [Run Raspberry Pi Zero W image in qemu](https://stackoverflow.com/questions/60127086/run-raspberry-pi-zero-w-image-in-qemu), github [source](https://github.com/igwtech/qemu).
* [How to set up QEMU 3.0 on Ubuntu 18.04](https://www.reddit.com/r/VFIO/comments/9pi2cd/how_to_set_up_qemu_30_on_ubuntu_1804/).


## building qemu from raspberri pi zero in wsl2 ubuntu
It is best if you make a directory somewhere in windows for the sources. Using powershell,
```bash
cd c:\Users\<user_name>\Documents
mkdir linux
```
Start ubuntu wsl2 instance. Now using shell, 
```bash
cd ~/<some_dir>
mkdir linux
sudo mount --bind "/mnt/c/Users/<user_name>/Documents/linux" linux
cd linux
mkdir qemu-build
cd qemu-build
```
This is where we will build qemu for raspberry pi zero.

Get qemu sources and dependencies,
```bash
git clone https://github.com/igwtech/qemu
# do followings only if you need to modify submodule sources
# git submodule init
# git submodule update --recursive
```
We are using a forked qemu source above because the official qemu repo doesn't provide support for raspberry pi zero. Feel free to diff the code with tags from original source, which will provide valuable insight to adding another arm processor support.

Activate source repositories by un-commenting the ``deb-src`` lines in ``/etc/apt/sources.list``.

Get qemu dependencies,
```bash
sudo apt-get update
sudo apt-get build-dep qemu
```

Create a build directory
```bash
mkdir build
cd build
```

configure qemu to build all qemu binaries,
```bash
../qemu/configure
```

Otherwise if you already have installed all the binaries, or only interested in ``qemu-arm`` and ``qemu-system-arm``,
this configures to build just those,
```bash
../qemu/configure --target-list=arm-softmmu,arm-linux-user
```
To find all the configuration options, run ``configure --help``.

Build and install qemu,
```bash
make
sudo make install
```

Run qemu for raspi0,
```bash
qemu-system-arm -machine raspi0 -serial stdio  -dtb bcm2708-rpi-zero-w.dtb -kernel kernel.img -append 'printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0'
```

qemu-kvm has problems in wsl2, currently it does not work properly.

## cross compile dbus
* <https://github.com/diwic/dbus-rs/blob/master/libdbus-sys/cross_compile.md>
* <https://serverfault.com/questions/892465/starting-systemd-services-sharing-a-session-d-bus-on-headless-system> headless dbus.
* <https://raspberrypi.stackexchange.com/questions/114739/how-to-install-pi-libraries-to-cross-compile-for-pi-zero-in-wsl2>.

