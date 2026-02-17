#!/bin/bash 

sudo add-apt-repository ppa:kisak/kisak-mesa --yes
sudo apt update
sudo apt install -y libgl1-mesa-dri mesa-vulkan-drivers vulkan-tools

