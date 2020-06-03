---
title: Using Raspberry Pi
---

# {{ page.title }}

## Pi Documentation
* <https://www.raspberrypi.org/documentation/>.
* <https://www.raspberrypi.org/documentation/configuration/>.
* <https://pifi.imti.co/>.
* <https://youtu.be/qeHpXVUwI08>
* <https://youtu.be/RlgLIr2gZFg>

## IOT 
If we want to make an IOT with Pi, we will need to setup a headless pi first. We will use raspberry pi zero W since it has built-in wireless which
can be used to network for development as well as connecting the device to the internet without additional hardware.  

## Setup for development
We will use a PC to do code editing and run code to test during development. We will setup the wifi to connect the pi to a network that the PC is connected to.

### Setup for headless wifi
First burn the minimal boot image to SD card using the PC. After the image is prepared,  
take out the and reinsert the SD card in the PC to make the new filesystem visible. Now go to the root directory
of the SD.

Create following two files in the disk image root directory.

1. A ``wpa_supplicant.conf`` file with following content,
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

2. An empty file called ``ssh``. This will enable the ssh port in pi.

These two files will setup the config during boot and then will be deleted during boot.

Insert the SD in pi and turn power on. After the boot completed,  
we can connect to headless pi thru ssh from the computer on the wifi network for development.

From ssh shell, we can scan wifi networks from pi to see all the available access points.
```bash
 sudo iwlist wlan0 scan
```

### Create a Samba share
We will use code editor on the PC to edit files directly on the pi. We will 
install Samba to do this.
Samba is available in Raspbian’s standard software repositories. We’re going to update our repository index, make sure our operating system is fully updated, and install Samba using apt-get. In ssh terminal and type:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install samba samba-common-bin
```
We’re going to create a dedicated shared directory on our Pi’s SD. 
```
sudo mkdir -m 1777 /home/pi/devcode
```
This command sets the sticky bit (1) to help prevent the directory from being accidentally deleted and gives read/write/execute (777) permissions on it.

Edit Samba’s config files to make the file share visible to the Windows PCs on the network.
```
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.orig
sudo nano /etc/samba/smb.conf
```
In our example, you’ll need to add the following entry:

```
[devcode]
Comment = Pi shared folder
path = /home/pi/devcode
writeable=Yes
create mask=0700
directory mask=0700
valid users = pi 
public=no
```

Before we start the server, you’ll want to set a Samba password - this is not the same as your standard default password (raspberry), but there’s no harm in reusing this if you want to, as this is a low-security, local network project.

```
sudo smbpasswd -a pi
```
Then set a password as prompted.

Finally, let’s restart Samba:
```
sudo /etc/init.d/samba restart
```
From now on, Samba will start automatically whenever you power on your Pi. 

## Configure IOT setup mechanism by user.
If we build IOT device, it needs to be configured. For example the user needs to setup the wifi connection information so that it can be connected to internet.
The question is, how do we set it up with a PC or cell phone and input those
setup?

### Idea 1: configure via wifi.
Set it up initially as a wifi access point on power up. 
Then use it to setup up the configuration.

Perhaps We can run both ap and client at the same time? Or a reset switch to select the mode. Or we can use some other algorithmic way turn on the access point. We can use captive portal to show the user interface.
* <https://www.raspberrypi.org/forums/viewtopic.php?t=211542>.
* <https://serverfault.com/questions/869857/systemd-how-to-selectively-disable-wpa-supplicant-for-a-specific-wlan-interface>.
* <https://pifi.imti.co/>.
* <https://en.wikipedia.org/wiki/Captive_portal>.

### Idea 2:
make pi a bluetooth device, connect your phone to it with an app the should display user interface and send the info to the device to get it configured.

> is it possible that device will send a html page while the bt connections act as network connection? probably not a whole lot different from idea 1 if we do that.

### Idea 3:
Connect the device with a usb cable to a computer of phone, again the same concept a user interface shows up to configure.
* <https://desertbot.io/blog/headless-pi-zero-ssh-access-over-usb-windows>
* <https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README>


> todo: check how to use docker container in pi

## Raspberry pi as Access Point and Wifi client

This is an example of how the *idea 1* can be implemented. This was collected from the tutorials found on internet. 

> It is based on IOT wifi's [solution](https://pifi.imti.co/), but I wanted to use a language other than Go to manage my wifi connections, so all changes are within the standard Raspbian Stretch OS.

These steps are (as best as I can remember) in the order that I did them in:

### 1. Update system
Run apt-get update and upgrade to make sure you have the latest and greatest.
```
sudo apt-get update
sudo apt-get upgrade
```

This may take a while depending on connection speed.

### 2. Install hostapd and dnsmasq
Install the hostapd access point daemon and the dnsmasq dhcp service.
```bash
sudo apt-get install hostapd dnsmasq
```

### 3. Edit configuration files
Here we need to edit the config files for dhcpcd, hostapd, and dnsmasq so that they all play nice together. We **do NOT**, as in past implementations, make any edits to the ``/etc/network/interfaces`` file. If you do it can cause problems, check tutorial notes [here](https://raspberrypi.stackexchange.com/questions/37920/how-do-i-set-up-networking-wifi-static-ip-address/37921#37921).

Edit ``/etc/dhcpcd.conf``
```
interface uap0
	static ip_address=192.168.50.1/24
    nohook wpa_supplicant
```
This sets up a static IP address on the uap0 interface that we will set up in the startup script. The nohook line prevents the 10-wpa-supplicant hook from running wpa-supplicant on this interface.

Replace ``/etc/dnsmasq.conf``
Move the dnsmasq original file to save a copy of the quite useful example, you may even want to use some of the RPi-specific lines at the end. I did not test my solution with those.
```
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
```
Create a new ``/etc/dnsmasq.conf`` and add the following to it:
```
interface=lo,uap0    # Use interfaces lo and uap0
bind-interfaces      # Bind to the interfaces
server=8.8.8.8       # Forward DNS requests to Google DNS
domain-needed        # Don't forward short names
bogus-priv           # Never forward addresses in the non-routed address spaces

# Assign IP addresses between 192.168.70.50 and 192.168.70.150
# with a 12-hour lease time
dhcp-range=192.168.70.50,192.168.70.150,12h

# The above address range is totally arbitrary; use your own.
```

Create file ``/etc/hostapd/hostapd.conf`` and add the following:
(Feel free to delete the commented out lines)

```
# Set the channel (frequency) of the host access point
channel=1

# Set the SSID broadcast by your access point (replace with your own, of course)
ssid=IOT-Config

# This sets the passphrase for your access point (again, use your own)
wpa_passphrase=passwordBetween8and64charactersLong

# This is the name of the WiFi interface we configured above
interface=uap0

# Use the 2.4GHz band
# (untested: ag mode to get 5GHz band)
hw_mode=g

# Accept all MAC addresses
macaddr_acl=0

# Use WPA authentication
auth_algs=1

# Require clients to know the network name
ignore_broadcast_ssid=0

# Use WPA2
wpa=2

# Use a pre-shared key
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
driver=nl80211

# I commented out the lines below in my implementation, but I kept them here for reference.

# Enable WMM
#wmm_enabled=1

# Enable 40MHz channels with 20ns guard interval
#ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
```

> Note: The channel written here MUST match the channel of the wifi that you connect to in client mode (via wpa-supplicant). If the channels for your AP and STA mode services do not match, then one or both of them will not run. This is because there is only one physical antenna. It cannot cover two channels at once.

Edit file ``/etc/default/hostapd`` and uncomment ``DAEMON_CONF`` line. Add the following,

```
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```

### 4. Create startup script
Add a new file ``/usr/local/bin/wifistart`` (or whatever name you like best), and add the following to it:
```
#!/bin/bash

# Redundant stops to make sure services are not running
echo "Stopping network services (if running)..."
systemctl stop hostapd.service
systemctl stop dnsmasq.service
systemctl stop dhcpcd.service

# Make sure no uap0 interface exists (this generates an error; we could probably use an if statement to check if it exists first)
echo "Removing uap0 interface..."
iw dev uap0 del

# Add uap0 interface (this is dependent on the wireless interface being called wlan0, which it may not be in Stretch)
echo "Adding uap0 interface..."
iw dev wlan0 interface add uap0 type __ap

# Modify iptables (these can probably be saved using iptables-persistent if desired)
echo "IPV4 forwarding: setting..."
sysctl net.ipv4.ip_forward=1
echo "Editing IP tables..."
iptables -t nat -A POSTROUTING -s 192.168.70.0/24 ! -d 192.168.70.0/24 -j MASQUERADE

# Bring up uap0 interface. Commented out line may be a possible alternative to using dhcpcd.conf to set up the IP address.
#ifconfig uap0 192.168.70.1 netmask 255.255.255.0 broadcast 192.168.70.255
ifconfig uap0 up

# Start hostapd. 10-second sleep avoids some race condition, apparently. It may not need to be that long. (?) 
echo "Starting hostapd service..."
systemctl start hostapd.service
sleep 10

# Start dhcpcd. Again, a 5-second sleep
echo "Starting dhcpcd service..."
systemctl start dhcpcd.service
sleep 5

echo "Starting dnsmasq service..."
systemctl start dnsmasq.service
echo "wifistart DONE"
```

There are other and better ways of automating this startup process, which I adapted from IOT wifi's code [here](https://github.com/cjimti/iotwifi). This demonstrates the basic functionality in a simple script.

### 5. Edit rc.local system script
There are other ways of doing this, including creating a daemon that can be used by systemctl, which I would recommend doing if you want something that will restart if it fails. Adafruit has a simple write-up on that [here](https://learn.adafruit.com/running-programs-automatically-on-your-tiny-computer/systemd-writing-and-enabling-a-service). I used ``rc.local`` for simplicity here.

Add the following to your ``/etc/rc.local`` script above the exit 0 line. Note the spacing between ``/bin/bash`` and ``/usr/local/bin/wifistart``.
```
/bin/bash /usr/local/bin/wifistart
```
### 6. Disable regular network services
The wifistart script handles starting up network services in a certain order and time frame. Disabling them here makes sure things are not run at system startup.
```
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq
sudo systemctl stop dhcpcd
sudo systemctl disable hostapd
sudo systemctl disable dnsmasq
sudo systemctl disable dhcpcd
```
### 7. Reboot
```
sudo reboot
```

If you want to test the code directly and view the output, just run
```
sudo /usr/local/bin/wifistart
```
from the terminal after commenting out the ``wifistart`` script line in ``rc.local``.

## Preparing for distribution.
We will put minimal code on the sdio, the boot image should be downloaded and prepared by the user during configuration. TODO...

* Imaging sdio source code <https://github.com/raspberrypi/rpi-imager>

