sudo apt install -y pulseaudio 
systemctl --user disable pipewire.socket
systemctl --user disable pipewire 

systemctl --user stop pipewire.socket 
systemctl --user stop pipewire

systemctl --user enable pulseaudio.socket
systemctl --user enable pulseaudio

systemctl --user restart pulseaudio.socket
