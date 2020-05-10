---
title: Ubuntu
---

# {{ page.title }}

## Debugging kernel or system program crash

* [Beginning Kernel Crash Debugging on Ubuntu 18.10](https://ruffell.nz/programming/writeups/2019/02/22/beginning-kernel-crash-debugging-on-ubuntu-18-10.html).
* [Kernel panic - not syncing: Attempted to kill init!](https://askubuntu.com/questions/92946/cannot-boot-because-kernel-panic-not-syncing-attempted-to-kill-init).
* Regarding Annoying crash report- [How To Fix System Program Problem Detected In Ubuntu](https://itsfoss.com/how-to-fix-system-program-problem-detected-ubuntu/).

## File system check

The simplest way to force ``fsck`` filesystem check on a root partition
eg. ``/dev/sda1`` is to create an empty file called forcefsck in the 
partition's root directory.

```bash
# touch /forcefsck
```

This empty file will temporarily override any other settings and force 
``fsck`` to check the filesystem on the next system reboot. Once the 
filesystem is checked the ``forcefsck`` file will be removed thus next time 
you reboot your filesystem will NOT be checked again. Once boot completes, 
the result of ``fsck`` will be available in ``/var/log/boot.log``. Also
the ram filesystem used during boot will log it in 
``/run/initramfs/fsck.log``. This file will be lost as soon as the system 
is shut down since the ram filesystem is volatile.

## Security
* [What Is AppArmor, and How Does It Keep Ubuntu Secure?](https://www.howtogeek.com/118222/htg-explains-what-apparmor-is-and-how-it-secures-your-ubuntu-system/)


## Setting up ubuntu server with lubuntu desktop in a VirtualBox VM

### Set up the VM with,
* 4G memeory.
* 32G vdi disk. 
* Network: NAT / Host only 
* Clipboard: bidirectional.

### install linux and desktop

Install ubuntu server from server.iso from a USB drive. Next,

```bash
sudo apt-get update
# Install lubuntu desktop
sudo apt-get install lubuntu-desktop
# get guest addition
sudo apt-get install virtualbox-guest-x11
```

Now go to ``Start > Preferences > Monitor settings`` and Select a resolution of your choice. 

### Custom Resolution

First we need to find out what display outputs are available.
```bash
$ xrandr -q
Screen 0: minimum 640 x 400, current 1600 x 1200, maximum 1600 x 1200
Virtual1 connected 1600x1200+0+0 0mm x 0mm
   1600x1200       0.0* 
   1280x1024       0.0  
   640x480         0.0  
...
```
This means ``Virtual1`` is the first output device, there might be more listed. Find which output you want the monitor to connect to.

Lets say we want a monitor resolution of 960 x 600 @ 60Hz.  
```bash
# get a Modeline 
$ gtf 960 600 60
```
Lets say output will look like:
```txt
# 960x600 @ 60.00 Hz (GTF) hsync: 37.32 kHz; pclk: 45.98 MHz
Modeline "960x600_60.00"  45.98  960 1000 1096 1232  600 601 604 622  -HSync +Vsync
```
The string ``960x600_60.00`` is just an identifier proposed. For the following you can substitute it to anything more meaningful.

Now we will use this Modeline content to set our configuration,
```bash
# define a mode
xrandr --newmode "960x600_60.00"  45.98  960 1000 1096 1232  600 601 604 622  -HSync +Vsync
# map this mode to a output
xrandr --addmode Virtual1 "960x600_60.00"
```

At this point you can switch to the new resolution by 
going to ``Start > Preferences > Monitor settings`` and Selecting the resolution added. 
Alternatively you can switch mode for the output from the terminal, 
```bash
xrandr --output Virtual1 --mode "960x600_60.00"
```

The whole thing can be turned into a a bash script.
```bash
#!/bin/bash

# Get the modeline information we want for the following resolutions:
RES="960 600 60"
DEVICE=$( xrandr -q | grep " connected" | cut -d ' ' -f1 )
# modeline settings
SETTINGS=$( gtf $RES | grep Modeline | cut -d ' ' -f4-16 )
# Get name of modelines from settings
NAME=$( echo $SETTINGS | cut -d ' ' -f1 )
# Create the new modelines via xrandr
xrandr --newmode $SETTINGS
# Add the newly created modelines to devices
xrandr --addmode $DEVICE $NAME
# Finally, enable the new modes
xrandr --output $DEVICE --mode $NAME0
```









