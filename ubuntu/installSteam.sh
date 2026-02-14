#!/bin/bash 

wget https://repo.steampowered.com/steam/archive/stable/steam-launcher_latest_all.deb 
sudo apt install -yf ./steam-launcher_latest_all.deb 


mkdir -p "$HOME/.local/share/applications"

cat > "$HOME/.local/share/applications/steam-fex.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Steam (FEX)
Comment=Launch Steam using FEX
Exec=bash -lc "STEAMOS=1 STEAM_RUNTIME=1 FEX /usr/bin/steam"
Icon=steam
Terminal=false
Categories=Game;
StartupNotify=true
EOF

cat > "$HOME/.local/share/applications/steam-big-picture.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Steam (FEX)
Comment=Launch Steam Big Picture using FEX
Exec=bash -lc "STEAMOS=1 STEAM_RUNTIME=1 FEX /usr/bin/steam -tenfoot"
Icon=steam
Terminal=false
Categories=Game;
StartupNotify=true
EOF

chmod +x "$HOME/.local/share/applications/steam-fex.desktop"
chmod +x "$HOME/.local/share/applications/steam-big-picture.desktop"

echo "Steam (FEX) shortcut created."

FEXBash steam
