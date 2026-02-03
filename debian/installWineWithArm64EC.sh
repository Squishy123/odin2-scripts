#!/bin/bash 

sudo sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/debian.sources
sudo dpkg --add-architecture i386
sudo apt update

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

export PATH="$TOOLCHAIN_PATH/bin:$PATH"
source ~/.bashrc

cd ~ 
mkdir -p sys && cd sys

git clone --depth=1 -b upstream-arm64ec https://github.com/bylaws/wine.git

cd wine 

# mkdir -p wine-32-build
mkdir -p wine-64-build

cd wine-64-build
../configure --enable-archs=arm64ec,aarch64,i386 --prefix=/usr --with-mingw=clang --disable-tests
make -j$(nproc)
sudo --preserve-env=PATH make install -j$(nproc)



# cd ../wine-32-build
# PKG_CONFIG_PATH=/usr/lib/i686-linux-gnu ../configure --enable-archs=arm64ec,aarch64,i386 --prefix=/usr --with-mingw=clang --disable-tests --with-wine64=../wine-64-build
# make -j$(nproc)
# sudo --preserve-env=PATH make install -j$(nproc) # install 32bit first

# cd ../wine-64-build
# sudo --preserve-env=PATH make install -j$(nproc)


# build fex for arm64ec and also wow64
cd ~/sys/FEX 

mkdir build-arm64ec
cd build-arm64ec
cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../Data/CMake/toolchain_mingw.cmake -DCMAKE_INSTALL_LIBDIR=/usr/lib/wine/aarch64-windows -DENABLE_LTO=False -DMINGW_TRIPLE=arm64ec-w64-mingw32 -DBUILD_TESTING=False -DENABLE_JEMALLOC_GLIBC_ALLOC=False -DCMAKE_INSTALL_PREFIX=/usr ..
ninja
sudo ninja install

cd ..
mkdir build-wow64
cd build-wow64
cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../Data/CMake/toolchain_mingw.cmake -DCMAKE_INSTALL_LIBDIR=/usr/lib/wine/aarch64-windows -DENABLE_LTO=False -DMINGW_TRIPLE=aarch64-w64-mingw32 -DBUILD_TESTING=False -DENABLE_JEMALLOC_GLIBC_ALLOC=False -DCMAKE_INSTALL_PREFIX=/usr ..
ninja
sudo ninja install
cd ..


