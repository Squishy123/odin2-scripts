#!/bin/bash 

wget https://repo.steampowered.com/steam/archive/stable/steam-launcher_latest_all.deb 
sudo apt install -yf ./steam-launcher_latest_all.deb 

FEXBash steam
