#!/bin/bash 

wget https://repo.steampowered.com/steam/archive/stable/steam-launcher_latest_all.deb 
sudo apt install -yf ./steam-launcher_latest_all.deb 


mkdir -p "$HOME/.local/share/applications"

cat > "$HOME/.local/share/applications/steam-fex.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Steam (FEX)
Comment=Launch Steam using FEX
Exec=bash -lc "FEXBash steam"
Icon=steam
Terminal=false
Categories=Game;
StartupNotify=true
EOF

chmod +x "$HOME/.local/share/applications/steam-fex.desktop"

echo "Steam (FEX) shortcut created."
