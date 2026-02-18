#!/bin/bash 

sudo apt install curl ca-certificates -y
curl -s https://repo.waydro.id | sudo bash
sudo apt install waydroid -y

# we have to manually edit the waydroid-net script since we don't want to use legacy
sudo sed -i 's/iptables-legacy//g' /usr/lib/waydroid/data/scripts/waydroid-net.sh
sudo sed -i 's/ip6tables-legacy//g' /usr/lib/waydroid/data/scripts/waydroid-net.sh

