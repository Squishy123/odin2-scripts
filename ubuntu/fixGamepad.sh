#!/bin/bash 

cat > /etc/udev/rules.d/99-ayn-odin2.rules <<EOF 
KERNEL=="event*", ATTRS{name}=="Ayn Odin2 Gamepad", ENV{ID_INPUT}="1", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_MOUSE}="", TAG+="uaccess", MODE="0666"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger
