#!/bin/bash 

# SETUP SCRIPT TO RUN A BUNCH OF STUFF SEQUENTIALLY 

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

./fixAudio.sh 

./installLutris.sh 

./installBox64.sh 

./fixUbuntuSources.sh

./installWine.sh

./installFex.sh

./installSteam.sh

./installWaydroid.sh

./installEden.sh
