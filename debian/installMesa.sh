#!/bin/bash 

# add deb-src to sources
sudo sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/debian.sources
sudo apt update 

# install dependencies
sudo apt -y build-dep mesa 
sudo apt -y install python3 python3-pip
pip install meson --break-system

export PATH="$HOME/.local/bin:$PATH"

mesonExec="$HOME/.local/bin/meson"

# build mesa inside sys folder
cd ~ 
mkdir -p sys && cd sys 
git clone https://gitlab.freedesktop.org/mesa/mesa.git
cd mesa 

# yes!
mesonExec setup build/ -Dprefix=/usr -Dplatforms=x11,wayland -Dvulkan-drivers=freedreno -Dgallium-drivers=freedreno
mesonExec compile -C build/
sudo mesonExec install -C build
