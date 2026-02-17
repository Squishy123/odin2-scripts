#!/bin/bash 

wget https://github.com/eden-emulator/Releases/releases/download/v0.2.0-rc1/Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage 

mv Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage ~/sys/Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage 
chmod +x ~/sys/Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage 

cat > "$HOME/.local/share/applications/eden.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Eden
Comment=Launch Eden 
Exec="$HOME/Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage"
Icon=eden
Terminal=false
Categories=Game;
StartupNotify=true
EOF

 
