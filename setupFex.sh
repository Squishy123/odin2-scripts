#!/bin/bash 

sudo apt install -y debootstrap patchelf

export PATH=$PATH:/sbin:/usr/sbin

cd "$(dirname "$0")"

FEXRootFSFetcher 
cp installMesa.sh  ~/.fex-emu/RootFS/Ubuntu_24_04/
cd ~/.fex-emu/RootFS/Ubuntu_24_04/ 
./chroot chroot
./installMesa.sh





