---
title: Angular, bootstrap, firebase
---

# {{ page.title }}

documentation
* <https://www.raspberrypi.org/documentation/>
* <https://www.raspberrypi.org/documentation/configuration/>



* <https://youtu.be/qeHpXVUwI08>
* <https://youtu.be/RlgLIr2gZFg>


scan wifi networks
```bash
 sudo iwlist wlan0 scan
```


## setup for wifi
drop two files in the disk image directory

create ``wpa_supplicant.conf`` file with following content
```auto
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
	ssid="Wifi-Network-Name"
	psk="Wifi-Network-Password"
	key_mgmt=WPA-PSK
}
```

create an empty file called ``ssh``

These two files will setup the config during boot and then will be deleted.


QUestion,
if we build a embedded system how do we set it up with a PC or cell phone?

Idea 1: set it up initially as a wifi access point on power up.
use it to setup up the configuration.


perhaps We can run both ap and client at the same time?
* <https://www.raspberrypi.org/forums/viewtopic.php?t=211542>


Idea 2:
make pi a bluetooth device, connect your phone to it with an app the should display user interface and send the info to the device to get it configured.
> is it possible that device will send a html page while the bt connections act as network connection? probably not a whole lot different from idea 1 if we do that.

Idea 3:
Connect the device with a usb cable to a computer of phone, again the same concept a user interface shows up to configure.
* <https://desertbot.io/blog/headless-pi-zero-ssh-access-over-usb-windows>
* <https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README>






