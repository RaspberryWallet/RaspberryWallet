# RaspberryWallet

## Installation
1. Install DietPi on the device, remember to set WiFi in dietpi-wifi.txt on FAT32 partition.
2. Find in your router (or via avahi) and SSH to dietpi@_hostname_.
3. Update and everything what DietPi wants, change the SSH client to OpenSSH.
4. Reboot.
5. Remove bloat `sudo apt purge dropbear lighttpd`
6. Install useful software for the future `sudo apt -y install openssh-server git net-tools`.
7. Reboot.
8. On host machine, edit ~/.ssh/known_hosts and remove the position with Pi's IP, connect via SSH again.

## Optimizing 
1. `sudo nano /etc/bashrc.d/dietpi-login.sh` and comment out everything (or just delete).
2. `sudo systemctl disable dietpi-boot ; sudo systemctl disable dietpi-postboot ; sudo systemctl disable dietpi-preboot`

## Setting up the USB network card
1. `sudo nano /boot/cmdline.txt`, add at the end `modules-load=dwc2,g_ether` and in `/boot/config.txt` set `dtparam=audio=off` (audio is not needed) and **add a line** `dtoverlay=dwc2`.
2. `sudo apt -y install isc-dhcp-server`
3. `cd; sudo cp -r RaspberryWallet/etc/dhcp /etc/; sudo cp -r RaspberryWallet/etc/network /etc/`.
4. Reboot.

## Getting the wallet things
1. `cd; git clone https://github.com/RaspberryWallet/RaspberryWallet.git`
2. `sudo cp -r RaspberryWallet/opt/* /opt/`
3. `sudo useradd -M wallet`
4. `sudo usermod -L wallet`
5. `sudo nano /etc/passwd` and in the last line change `/home/wallet` to `/opt/wallet`.
6. `sudo chown -R wallet /opt/wallet; sudo chgrp -R wallet /opt/wallet`.
7. `sudo usermod -a -G netdev wallet`


