#!/bin/bash 
sudo sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/ubuntu.sources
sudo apt update 

sudo apt -y build-dep mesa 
sudo apt -y install python3 python3-pip
sudo python3-pip install meson --break-system

cd ~ 
mkdir -p sys && cd sys 
git clone https://gitlab.freedesktop.org/mesa/mesa.git
cd mesa 
meson setup build/ -Dprefix=/usr -Dplatforms=x11,wayland -Dvulkan-drivers=freedreno -Dgallium-drivers=freedreno
meson compile -C build/
sudo meson install -C build/
