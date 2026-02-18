sudo apt install -y pulseaudio 

systemctl --global stop pipewire.socket 
systemctl --global stop pipewire

sudp systemctl disable pipewire.socket 
sudo systemctl disable pipewire

systemctl --global disable pipewire.socket
systemctl --global disable pipewire 

sudo systemctl enable pulseaudio.socket
sudo systemctl enable pulseaudio

systemctl --global enable pulseaudio.socket
systemctl --global enable pulseaudio

systemctl --global restart pulseaudio.socket
