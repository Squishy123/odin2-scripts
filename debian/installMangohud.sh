#!/bin/bash 

cd ~ 
mkdir -p sys && cd sys 

git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
cd MangoHud

./build.sh build -Dmangoapp=true -Dmangohudctl=true

