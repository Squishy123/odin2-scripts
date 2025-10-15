#!/bin/bash 

sudo apt-get -y install git gcc-aarch64-linux-gnu cmake make python3

cd ~ 
mkdir -p sys && cd sys 

git clone --recursive https://github.com/ptitSeb/box64
cd box64
mkdir build && cd build
cmake .. -D BOX32=1 -D BOX32_BINFMT=1 -D SD8G2=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo
make -j"$(nproc)"
sudo make install

