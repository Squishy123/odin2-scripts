#!/bin/bash 

sudo apt-get -y install git gcc-aarch64-linux-gnu cmake make python3

cd ~ 
mkdir -p sys && cd sys 

git clone --recursive https://github.com/ptitSeb/box64
cd box64

~/sys/odin2-scripts/install-meson-deps.sh meson.build

mkdir build && cd build
cmake .. -D ARM_DYNAREC=ON -D BOX32=ON -D BOX32_BINFMT=ON -D SD8G2=ON -D CMAKE_BUILD_TYPE=RelWithDebInfo
make -j"$(nproc)"
sudo make install
sudo systemctl restart systemd-binfmt
