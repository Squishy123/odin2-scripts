#!/bin/bash 

# SETUP SCRIPT TO RUN A BUNCH OF STUFF SEQUENTIALLY 

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
