#!/bin/bash 

# SETUP SCRIPT TO RUN A BUNCH OF STUFF SEQUENTIALLY 

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

sudo apt reinstall snapd 

./installMesaFromPPA.sh

./installLutris.sh 

./installBox64.sh 

./fixUbuntuSources.sh

./installWine.sh

./installWaydroid.sh

./installEden.sh

./installFex.sh

./installSteam.sh
