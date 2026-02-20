#!/bin/bash
set -e

# Must be run as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

# Detect Ubuntu codename
if command -v lsb_release >/dev/null 2>&1; then
    CODENAME=$(lsb_release -cs)
elif [ -f /etc/os-release ]; then
    . /etc/os-release
    CODENAME=$VERSION_CODENAME
else
    echo "Unable to detect Ubuntu codename."
    exit 1
fi

if [ -z "$CODENAME" ]; then
    echo "Could not determine Ubuntu codename."
    exit 1
fi

FILE="/etc/apt/sources.list.d/ubuntu-archive.sources"

echo "Creating $FILE for Ubuntu codename: $CODENAME"

cat > "$FILE" <<EOF
Types: deb deb-src
URIs: http://archive.ubuntu.com/ubuntu
Suites: ${CODENAME} ${CODENAME}-updates ${CODENAME}-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
Architectures: amd64

Types: deb deb-src
URIs: http://security.ubuntu.com/ubuntu
Suites: ${CODENAME}-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
Architectures: amd64
EOF

echo "Updating package lists..."
apt update

echo "Done."

FILE="/etc/apt/sources.list.d/ubuntu.sources"
if grep -q "^Architectures:" "$FILE"; then
    echo "Replacing existing Architectures line..."
    sudo sed -i 's/^Architectures:.*/Architectures: arm64/' "$FILE"
else
    echo "No Architectures line found — appending..."
    echo "Architectures: arm64" | sudo tee -a "$FILE" > /dev/null
fi
apt update


