#!/bin/bash 

echo "THIS IS NOT WORKING RN"
exit

sudo dpkg --add-architecture amd64
sudo dpkg --add-architecture i386 

sudo apt update

cd ~ 
mkdir -p sys && cd sys 

git clone --recursive https://github.com/ptitSeb/box86 

cd box86 
./install_steam.sh

