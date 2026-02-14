#!/bin/bash 

echo "Add FEX-EMU PPA"

sudo add-apt-repository -y ppa:fex-emu/fex
sudo apt update


sudo apt install -y wine fex-emu-armv8.4 fex-emu-wine debootstrap patchelf squashfs-tools


# need to add this to bashrc for certain commands necessary in chroot
if ! grep -q '/sbin:/bin' ~/.bashrc; then
    echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH' >> ~/.bashrc
fi

source ~/.bashrc

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# fetch and extract ubuntu rootfs
wget "https://rootfs.fex-emu.gg/Ubuntu_24_04/2025-03-04/Ubuntu_24_04.sqsh" -P ~/.fex-emu/RootFS/ 
mkdir -p ~/.fex-emu/RootFS/Ubuntu_24_04
unsquashfs -d ~/.fex-emu/RootFS/Ubuntu_24_04 ~/.fex-emu/RootFS/Ubuntu_24_04.sqsh

# execute commands inside chroot to get drivers
cd ~/.fex-emu/RootFS/Ubuntu_24_04/ 

source ~/.bashrc

# replace chroot.py with ours
rm chroot.py
wget https://raw.githubusercontent.com/FEX-Emu/RootFS/refs/heads/main/Scripts/chroot.py 

chmod a+x chroot.py

sudo ./chroot.py chroot /bin/bash -c "dpkg --add-architecture i386 && apt-get update && apt upgrade -y && apt install -y vulkan-tools libgl1-mesa-dri mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386"


# configure fex to use chroot 

cat <<EOF > ~/.fex-emu/Config.json
{
    "Config": {
        "MaxInst": "5000",
        "RootFS": "Ubuntu_24_04"
    }
}
EOF



# add app launcher for fexconfig
mkdir -p "$HOME/.local/share/applications"

cat > "$HOME/.local/share/applications/fexconfig.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=FEXConfig
Comment=Launch FEX Configuration Tool
Exec=bash -lc "FEXConfig"
Icon=preferences-system
Terminal=false
Categories=Settings;Utility;
StartupNotify=true
EOF

chmod +x "$HOME/.local/share/applications/fexconfig.desktop"

echo "FEXConfig shortcut created."
