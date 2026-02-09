#!/bin/bash
cd ~/sys/odin2-scripts

set -e

DESKTOP_FILE="/usr/share/wayland-sessions/steam-big-picture.desktop"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi


# install polkit 
sudo apt install -y polkitd  

# copy over steamdm 
cp -R debian/steamdm/* ~/.local/bin

# Write the desktop entry
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=Steam Big Picture Mode
Comment=Start Steam in Big Picture Mode
Exec=/home/odin2/.local/bin/gamescope-session
Type=Application
EOF

# Set proper permissions
chmod 644 "$DESKTOP_FILE"

echo "Desktop entry created at $DESKTOP_FILE"

