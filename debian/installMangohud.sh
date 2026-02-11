#!/bin/bash 

cd ~ 
mkdir -p sys && cd sys 

git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
cd MangoHud

~/sys/odin2-scripts/install-meson-deps.sh meson.build 

meson build --prefix=/usr -Dmangoapp=true -Dmangohudctl=true
ninja -C build install 

