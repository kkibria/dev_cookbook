---
title: Rust language
---
# {{ page.title }}

## Learning rust
* [The rust book](https://doc.rust-lang.org/book/). Expand the TOC by pressing the menu icon on the top left of the page.

## Using rust in Raspberry pi
* [How to Get Started With Rust on Raspberry Pi](https://www.makeuseof.com/tag/getting-started-rust-raspberry-pi/)
* [Program the real world using Rust on Raspberry Pi](https://opensource.com/article/19/3/physical-computing-rust-raspberry-pi)
* [Cross compiling Rust for Raspberry Pi](https://dev.to/h_ajsf/cross-compiling-rust-for-raspberry-pi-4iai)
* [Cross Compiling Rust for the Raspberry Pi](https://chacin.dev/blog/cross-compiling-rust-for-the-raspberry-pi/)
* [Anyone using Rust on a PI?](https://www.raspberrypi.org/forums/viewtopic.php?t=233928)
* [Learn to write an embedded OS in Rust](https://docs.rust-embedded.org/book/), [github](https://github.com/rust-embedded), [tutorials](https://github.com/rust-embedded/rust-raspberrypi-OS-tutorials).
* [Prebuilt Windows Toolchain for Raspberry Pi](https://gnutoolchains.com/raspberry/). Question: who are these people? where are the sources fro these tools?
* [Cross compiling Rust for ARM (e.g. Raspberry Pi) using any OS!](https://medium.com/@wizofe/cross-compiling-rust-for-arm-e-g-raspberry-pi-using-any-os-11711ebfc52b)
* [“Zero setup” cross compilation and “cross testing” of Rust crates](https://github.com/rust-embedded/cross)
* [Vagrant, Virtual machine for cross development](https://www.vagrantup.com/). I really like this setup, easy to use. Plays well with virtualbox.
* <https://github.com/kunerd/clerk/wiki/How-to-use-HD44780-LCD-from-Rust#setting-up-the-cross-toolchain>
* <https://opensource.com/article/19/3/physical-computing-rust-raspberry-pi>
* <https://github.com/japaric/rust-cross>

## Cross compiling rust on ubuntu

Compiling rust on pi will take for ever, cross compiling will save development time. We will use ubuntu for cross compile.

If we are on a windows machine, WSL2 also is a good way to develop for raspberry. check [WSL 2: Getting started](https://www.youtube.com/watch?v=_fntjriRe48). Go ahead install ubuntu to run with WSL2.

Primary problem with cross compiling rust for pi zero is that zero is armv6 but other pis are armv7. At the time of this writing, gcc toolchain only has support for armv7. armv6 compile also produces armv7 image. So the toolchain needs to be installed from pi official tool repo from github which has armv6 support. See more in the following links,

* <https://github.com/rust-embedded/cross/issues/426>
* <https://github.com/japaric/rust-cross/issues/42>
* <https://hub.docker.com/r/mdirkse/rust_armv6>

Using this strategy we will go ahead and setup linux,
```bash
# install rust
curl https://sh.rustup.rs -sSf | sh
# Add the toolchain for Rust:
rustup target add arm-unknown-linux-gnueabihf
# get the right cross compiler-linker
sudo git clone https://github.com/raspberrypi/tools /opt/rpi_tools
```

We need to add our build target to ``~/.cargo/config`` by adding the following lines, so that rust knows which linker to use.
```auto
[target.arm-unknown-linux-gnueabihf]
linker = "/opt/rpi_tools/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc"
```

### Creating our project
Installing Rust will have installed cargo, the Rust package manager. We can use it to create a new project.
The ``--bin`` option will create the template necessary for building application.

```bash
$ cargo new hello --bin
$ cd hello
```
We can build and run our project locally on ubuntu, by running,
```bash
$ cargo run
``` 
 
To build our project for the Pi we use,

```bash
$cargo build --target=arm-unknown-linux-gnueabihf
```
We can check if we have successfully created an arm binary by using ``readelf``,
```bash
$ readelf -A target/arm-unknown-linux-gnueabihf/debug/hello
```

which will output,

```auto
Attribute Section: aeabi
File Attributes
  Tag_CPU_name: "6"
  Tag_CPU_arch: v6
  Tag_ARM_ISA_use: Yes
  Tag_THUMB_ISA_use: Thumb-1
  Tag_FP_arch: VFPv2
  Tag_ABI_PCS_GOT_use: GOT-indirect
  Tag_ABI_PCS_wchar_t: 4
  Tag_ABI_FP_rounding: Needed
  Tag_ABI_FP_denormal: Needed
  Tag_ABI_FP_exceptions: Needed
  Tag_ABI_FP_number_model: IEEE 754
  Tag_ABI_align_needed: 8-byte
  Tag_ABI_enum_size: int
  Tag_ABI_HardFP_use: Deprecated
  Tag_ABI_VFP_args: VFP registers
  Tag_CPU_unaligned_access: v6
  Tag_ABI_FP_16bit_format: IEEE 754
```

You can also try,
```bash
$ file target/arm-unknown-linux-gnueabihf/debug/hello
```
which will provide linking details.

Now we have executable built for armv6, which we can install into to pi and run.

For release, build with --release option
```bash
cargo build --release --target=arm-unknown-linux-gnueabihf
```
All the debug symbols will be stripped from the executable.

## Linux kernel module with rust
* <https://github.com/fishinabarrel/linux-kernel-module-rust>