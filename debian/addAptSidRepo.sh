#!/bin/bash 

SID_SOURCES="/etc/apt/sources.list.d/debian-sid.list"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Add Debian Sid repository if not already present
if ! grep -q "sid" "$SID_SOURCES" 2>/dev/null; then
    echo "Adding Debian Sid repositories..."
    cat <<EOF > "$SID_SOURCES"
deb http://deb.debian.org/debian/ sid main contrib non-free
deb-src http://deb.debian.org/debian/ sid main contrib non-free
EOF
    echo "Debian Sid repositories added to $SID_SOURCES"
else
    echo "Debian Sid sources already exist in $SID_SOURCES"
fi
