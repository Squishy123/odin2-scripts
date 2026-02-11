#!/bin/bash 

cd ~ 
mkdir -p sys && cd sys 

git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
cd MangoHud

~/sys/odin2-scripts/install-meson-deps.sh meson.build 

sudo apt install sudo apt install libxnvctrl-dev

meson setup --reconfigure build/ --prefix=/usr -Dmangoapp=true -Dmangohudctl=true
sudo ninja -C build install 


