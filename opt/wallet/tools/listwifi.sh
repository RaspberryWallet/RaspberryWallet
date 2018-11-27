#!/bin/bash
sudo ifconfig wlan0 up > /dev/null
sudo iwlist wlan0 scan | grep ESSID
