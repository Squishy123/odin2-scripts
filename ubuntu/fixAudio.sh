sudo apt install -y pulseaudio 

systemctl --user stop pipewire.socket 
systemctl --user stop pipewire

sudp systemctl disable pipewire.socket 
sudo systemctl disable pipewire

systemctl --user disable pipewire.socket
systemctl --user disable pipewire 

sudo systemctl enable pulseaudio.socket
sudo systemctl enable pulseaudio

systemctl --user enable pulseaudio.socket
systemctl --user enable pulseaudio

systemctl --user restart pulseaudio.socket
