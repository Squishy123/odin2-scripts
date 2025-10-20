#!/bin/bash 

# install dependencies
sudo apt install -y \
  debhelper-compat \
  lld \
  llvm \
  clang \
  gcc-mingw-w64-i686 \
  gcc-mingw-w64-x86-64 \
  libz-mingw-w64-dev \
  lzma \
  flex \
  bison \
  quilt \
  unzip \
  gettext \
  pkgconf \
  icoutils \
  sharutils \
  dctrl-tools \
  imagemagick \
  librsvg2-bin \
  fontforge-nox \
  khronos-api \
  unicode-data \
  unicode-idna \
  unicode-cldr-core \
  libgl-dev \
  libxi-dev \
  libxt-dev \
  libxmu-dev \
  libx11-dev \
  libxext-dev \
  libxfixes-dev \
  libxrandr-dev \
  libavcodec-dev \
  libxcursor-dev \
  libxrender-dev \
  libxkbfile-dev \
  libxxf86vm-dev \
  libxxf86dga-dev \
  libxinerama-dev \
  libavformat-dev \
  libglu1-mesa-dev \
  libxcomposite-dev \
  libxkbregistry-dev \
  libxml-libxml-perl \
  libssl-dev \
  libv4l-dev \
  libsdl2-dev \
  libkrb5-dev \
  libudev-dev \
  libpulse-dev \
  libldap2-dev \
  unixodbc-dev \
  libcups2-dev \
  libcapi20-dev \
  libvulkan-dev \
  libopenal-dev \
  libdbus-1-dev \
  freeglut3-dev \
  libunwind-dev \
  libpcap0.8-dev \
  libasound2-dev \
  libgphoto2-dev \
  libosmesa6-dev \
  libncurses-dev \
  libwayland-dev \
  libfreetype-dev \
  libgnutls28-dev \
  libpcsclite-dev \
  libusb-1.0-0-dev \
  libgettextpo-dev \
  libfontconfig-dev \
  ocl-icd-opencl-dev \
  libgstreamer-plugins-base1.0-dev

wget https://github.com/bylaws/llvm-mingw/releases/download/20250920/llvm-mingw-20250920-ucrt-ubuntu-22.04-aarch64.tar.xz -P ~/sys
tar -xvf ~/sys/llvm-mingw-20250920-ucrt-ubuntu-22.04-aarch64.tar.xz -C ~/sys

TOOLCHAIN_PATH=$(realpath ~/sys/llvm-mingw-20250920-ucrt-ubuntu-22.04-aarch64)

echo $TOOLCHAIN_PATH

if ! grep -q "$TOOLCHAIN_PATH" ~/.bashrc; then
  echo "export PATH=\"$TOOLCHAIN_PATH/bin:\$PATH\"" >> ~/.bashrc
fi
source ~/.bashrc

cd ~ 
mkdir -p sys && cd sys

git clone --depth=1 -b upstream-arm64ec https://github.com/bylaws/wine.git 
cd wine 

./configure --enable-archs=arm64ec,aarch64,i386 --prefix=/usr --with-mingw=clang --disable-tests
make -j$(nproc)
sudo --preserve-env=PATH make install -j$(nproc)

