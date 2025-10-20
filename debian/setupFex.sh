#!/bin/bash 

# install dependencies
sudo apt install -y debootstrap patchelf squashfs-tools

# need to add this to bashrc for certain commands necessary in chroot
if ! grep -q '/sbin:/bin' ~/.bashrc; then
    echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH' >> ~/.bashrc
fi

source ~/.bashrc

# fetch and extract ubuntu rootfs
wget "https://rootfs.fex-emu.gg/Ubuntu_24_04/2025-03-04/Ubuntu_24_04.sqsh" -P ~/.fex-emu/RootFS/ 
mkdir -p ~/.fex-emu/RootFS/Ubuntu_24_04
unsquashfs -d ~/.fex-emu/RootFS/Ubuntu_24_04 ~/.fex-emu/RootFS/Ubuntu_24_04.sqsh

# execute commands inside chroot to get drivers
cd ~/.fex-emu/RootFS/Ubuntu_24_04/ 


# have to rewrite the chroot command to allow us to pass in commands 
sed -i '/ChrootArgs\.append(os\.environ\['\''SHELL'\''\])/,+1c\
        if len(sys.argv) > 2:\
            ChrootArgs.extend(sys.argv[2:])\
        else:\
            ChrootArgs.append(os.environ['\''SHELL'\''])\
            ChrootArgs.append("-i")' chroot.py


./chroot.py chroot /bin/bash -c "dpkg --add-architecture i386 && apt-get update && apt install -y mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386"




