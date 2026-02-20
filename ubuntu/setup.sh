#!/bin/bash 

# SETUP SCRIPT TO RUN A BUNCH OF STUFF SEQUENTIALLY 

sudo apt reinstall snapd 

cd ~/sys/odin2-scripts/ubuntu/

./installMesaFromPPA.sh

./installLutris.sh 

./installBox64.sh 

sudo ./fixUbuntuSources.sh

./installWine.sh

./installWaydroid.sh

./installEden.sh

./installFex.sh

./installSteam.sh
