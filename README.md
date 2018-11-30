# RaspberryWallet

## Installation
1. Install DietPi on the device, remember to set WiFi in dietpi-wifi.txt on FAT32 partition.
2. Find in your router (or via avahi) and SSH.
3. Update and everything what DietPi wants, change the SSH client to OpenSSH.
4. Reboot.
5. `sudo apt purge dropbear lighttpd`
6. `sudo apt install openssh-server`
6. `sudo nano /etc/bashrc.d/dietpi-login.sh` and comment out everything (or just delete).
7. `sudo systemctl disable dietpi-boot ; sudo systemctl disable dietpi-postboot ; sudo systemctl disable dietpi-preboot`
8. Reboot.
9. On host machine, edit ~/.ssh/known_hosts and remove the position with Pi's IP, connect via SSH again.
10. 
