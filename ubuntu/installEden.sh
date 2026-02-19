#!/bin/bash 

mkdir ~/sys/eden 

cd ~/sys/eden

wget https://github.com/eden-emulator/Releases/releases/download/v0.2.0-rc1/Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage 

chmod +x Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage 

# ./Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage --appimage-extract

wget https://downloadr2.apkmirror.com/wp-content/uploads/2025/09/24/68c47ba0566d3_dev.eden.eden_emulator.png dev.eden_emu.eden.png

cat > "$HOME/.local/share/applications/eden.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Eden
Comment=Launch Eden 
Exec="$HOME/sys/eden/Eden-Linux-v0.2.0-rc1-aarch64-gcc-standard.AppImage"
Icon="$HOME/sys/eden/dev.eden_emu.eden.png"
Terminal=false
Categories=Game;
StartupNotify=true
EOF

 
