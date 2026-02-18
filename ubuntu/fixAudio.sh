sudo apt install -y pulseaudio 

systemctl --user stop pipewire.socket 
systemctl --user stop pipewire

sudp systemctl disable pipewire.socket 
sudo systemctl disable pipewire

sudo systemctl --global disable pipewire.socket
sudo systemctl --global disable pipewire 

sudo systemctl enable pulseaudio.socket
sudo systemctl enable pulseaudio

sudo systemctl --global enable pulseaudio.socket
sudo systemctl --global enable pulseaudio

systemctl --user restart pulseaudio.socket
