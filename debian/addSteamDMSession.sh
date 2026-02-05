#!/bin/bash
set -e

DESKTOP_FILE="/usr/share/wayland-sessions/steam-big-picture.desktop"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi



# install gamescope and polkit 
sudo apt install -y gamescope polkitd mangohud mangoapp

# Write the desktop entry
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=Steam Big Picture Mode
Comment=Start Steam in Big Picture Mode
Exec=/usr/games/gamescope -e -- STEAMOS=1 STEAM_RUNTIME=1 FEX /usr/bin/steam -bigpicture
Type=Application
EOF

# Set proper permissions
chmod 644 "$DESKTOP_FILE"

echo "Desktop entry created at $DESKTOP_FILE"

