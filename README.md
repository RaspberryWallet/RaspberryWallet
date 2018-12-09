# RaspberryWallet

## Installation
1. Install DietPi on the device, remember to set WiFi in dietpi-wifi.txt on FAT32 partition.
2. Find in your router (or via avahi) and SSH to dietpi@_hostname_.
3. Update and everything what DietPi wants, change the SSH client to OpenSSH.
4. Reboot.
5. Remove bloat `sudo apt purge dropbear lighttpd`
6. Install useful software for the future `sudo apt -y install openssh-server git net-tools avahi-daemon`.
7. Reboot.
8. On host machine, edit ~/.ssh/known_hosts and remove the position with Pi's IP, connect via SSH again.

## Optimizing 
1. Clean up login routines from DietPi checks: `sudo nano /etc/bashrc.d/dietpi-login.sh` and comment out everything (or just delete).
2. Disable all the DietPi system checks `sudo systemctl disable dietpi-boot ; sudo systemctl disable dietpi-postboot ; sudo systemctl disable dietpi-preboot`

## Getting Oracle Java
1. `sudo mkdir /usr/lib/jvm`
2. Get JDK8 https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html for ARM 32.
3. Copy JDK with scp to /home/dietpi.
4. Extract `cd; tar xf oracle-jdk.tar.gz`
5. Copy JDK `sudo mv jdk1.8.0_123 /usr/lib/jvm/`
6. Add permissions `sudo chmod -R o+r,o+x /usr/lib/jvm`
7. Create environment variable for JAVA_HOME `sudo su -c 'echo "export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_123/" > /etc/bashrc.d/java.sh'`
8. Link java as global executable `sudo ln -s /usr/lib/jvm/jdk1.8.0_191/bin/java /usr/bin/java`.

## Getting the wallet things
1. Clone repo: `cd; git clone https://github.com/RaspberryWallet/RaspberryWallet.git`
2. Copy application directory: `sudo cp -r RaspberryWallet/opt/* /opt/`
3. Create user wallet: `sudo useradd -M wallet`
4. Lock user wallet from logging in: `sudo usermod -L wallet`
5. Change home directory: `sudo nano /etc/passwd` and in the last line change `/home/wallet` to `/opt/wallet`.
6. Add wallet to group netdev and gpio `sudo usermod -a -G netdev wallet; sudo usermod -a -G gpio wallet`.
7. Move wpa_supplicant config and make it accessible to wallet `sudo mv /etc/wpa_supplicant/wpa_supplicant.conf /opt/wallet; sudo chown wallet:wallet /opt/wallet/wpa_supplicant.conf; sudo ln -s /opt/wallet/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf`
8. Allow wallet/netdev to do naughty things `sudo sh -c 'echo " " >> /etc/sudoers; grep "%netdev" RaspberryWallet/etc/sudoers >> /etc/sudoers'`.
9. Create service `sudo cp -r RaspberryWallet/etc/systemd /etc/`
10. Upload Manager.jar using scp to /home/dietpi/.
11. `sudo cp /home/dietpi/Manager-1.0-SNAPSHOT.jar /opt/wallet/Manager.jar`
12. Upload signed modules using scp to /home/dietpi.
13. Copy modules `sudo mkdir /opt/wallet/modules; sudo cp *Module.jar /opt/wallet/modules/`.
14. Get the config `wget https://github.com/RaspberryWallet/Backend/raw/master/config.yaml; sudo mv config.yaml /opt/wallet/`
15. Get keystore `wget https://github.com/RaspberryWallet/Backend/raw/master/RaspberryWallet.keystore; sudo mv RaspberryWallet.keystore /opt/wallet/`.
16. Set permissions: `sudo chown -R wallet:wallet /opt/wallet`.

## Setting up the USB network card and avahi: wallet.local
1. Edit kernel config `sudo nano /boot/cmdline.txt`, add at the end `modules-load=dwc2,g_ether` and in `/boot/config.txt` set `dtparam=audio=off` (audio is not needed) and **add a line** `dtoverlay=dwc2`.
2. Install a DHCP server `sudo apt -y install isc-dhcp-server`
3. Copy DHCP config `cd; sudo cp -r RaspberryWallet/etc/dhcp /etc/; sudo cp -r RaspberryWallet/etc/network /etc/`.
4. Move hostnames so avahi sets up _wallet.local_ `sudo mv RaspberryWallet/etc/hosts /etc/; sudo mv RaspberryWallet/etc/hostname /etc/`
5. Reboot.
6. Now you should be able to SSH to dietpi@10.7.7.2 or dietpi@wallet.local.
7. **Not working, investigating.**

## Firewall [!]
1. Check name of USB card (should be usb0) `ifconfig -a`.
2. Edit `nano RaspberryWallet/etc/iptables/rules.v4` and change all of 192.168.0.0/24 to your home subnet.
3. a. (Probably skip) Change all of `-i usb0` to `-i yourUSBnetworkCard`.
4. Install `sudo apt -y install iptables-persistent` and **select "Yes", save rules!**.
5. Replace tables `sudo cp -r RaspberryWallet/etc/iptables /etc/`
6. **BE WARNED** this can lock you out forever till reflash (or try via UART console if something goes wrong). *Reboot*.

## Install Manager (replace with Release installer)
1. Download latest Manager.jar release from github 
```bash
cd /opt/wallet && \
curl -s https://api.github.com/repos/RaspberryWallet/Backend/releases/latest \
| grep "browser_download_url.*jar" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
```
2. Download latest sources from github 
3. `cd; git clone https://github.com/RaspberryWallet/Backend.git && cd Backend`
4. `sudo cp config.yaml /opt/wallet/`
5. `sudo cp RaspberryWallet.keystore /opt/wallet/`
6. `sudo cp -r modules /opt/wallet/modules`
7. `sudo chown -R wallet:wallet /opt/wallet`


## Run Manager
1. `java -jar /opt/wallet/Manager.jar`
