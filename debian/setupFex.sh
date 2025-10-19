#!/bin/bash 

# install dependencies
sudo apt install -y debootstrap patchelf squashfs-tools

# need to add this to bashrc for certain commands necessary in chroot
grep -q '/sbin:/bin' ~/.bashrc || echo 'export PATH=$PATH:/sbin:/bin' >> ~/.bashrc
source ~/.bashrc

cd "$(dirname "$0")"

# fetch and extract ubuntu rootfs
wget "https://rootfs.fex-emu.gg/Ubuntu_24_04/2025-03-04/Ubuntu_24_04.sqsh" -P ~/.fex-emu/RootFS/ 
mkdir -p ~/.fex-emu/RootFS/Ubuntu_24_04
unsquashfs -d ~/.fex-emu/RootFS/Ubuntu_24_04 ~/.fex-emu/RootFS/Ubuntu_24_04.sqsh

# execute commands inside chroot to get drivers
cd ~/.fex-emu/RootFS/Ubuntu_24_04/ 
./chroot chroot

dpkg --add-architecture i386
apt-get update
apt install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386

exit




