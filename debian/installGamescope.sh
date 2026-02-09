#!/bin/bash 

cd ~ 
mkdir -p sys && cd sys 

git clone https://github.com/ValveSoftware/gamescope.git 

cd gamescope 

~/sys/odin2-scripts/install-meson-deps.sh meson.build 

# dependencies that were missing 
sudo apt install -y gslang-tools libluajit-5.1-dev 

meson setup build/
ninja -C build/
meson install -C build/ --skip-subprojects
