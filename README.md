# RaspberryWallet

## Installation
1. Install DietPi on the device, remember to set WiFi in dietpi-wifi.txt on FAT32 partition.
2. Find in your router (or via avahi) and SSH to dietpi@_hostname_.
3. Update and everything what DietPi wants, change the SSH client to OpenSSH.
4. Reboot.
5. `sudo apt purge dropbear lighttpd`
6. `sudo apt -y install openssh-server git net-tools`
6. `sudo nano /etc/bashrc.d/dietpi-login.sh` and comment out everything (or just delete).
7. `sudo systemctl disable dietpi-boot ; sudo systemctl disable dietpi-postboot ; sudo systemctl disable dietpi-preboot`
8. Reboot.
9. On host machine, edit ~/.ssh/known_hosts and remove the position with Pi's IP, connect via SSH again.
10. `cd; git clone https://github.com/RaspberryWallet/RaspberryWallet.git`
11. `sudo cp -r RaspberryWallet/opt/* /opt/`
12. `sudo useradd -M wallet`
13. `sudo usermod -L wallet`
14. `sudo nano /etc/passwd` and in the last line change `/home/wallet` to `/opt/wallet`.
15. `sudo chown -R wallet /opt/wallet; sudo chgrp -R wallet /opt/wallet`.
16. `sudo usermod -a -G netdev wallet`
17. `sudo nano /boot/cmdline.txt`, add at the end `modules-load=dwc2,g_ether` and in `/boot/config.txt` set `dtparam=audio=off` (audio is not needed) and add a line `dtoverlay=dwc2`.

