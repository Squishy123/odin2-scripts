#!/bin/bash 

wget https://github.com/lutris/lutris/releases/download/v0.5.20/lutris_0.5.20_all.deb 
sudo apt install -y --install-recommends ./lutris_0.5.20_all.deb 
sudo apt install -y librsvg2-common # not sure why this isn't included previously but we need it or stuff breaks

