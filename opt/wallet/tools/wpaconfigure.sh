#!/bin/bash
sudo dhclient -r wlan0
sudo killall wpa_supplicant
sudo ifdown --force wlan0
sleep 1
sudo wpa_supplicant -c /etc/wpa_supplicant/wpa_supplicant.conf -B -i wlan0
sleep 2
sudo dhclient -nw wlan0
