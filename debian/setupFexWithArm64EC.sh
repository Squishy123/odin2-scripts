#!/bin/bash

# RUN THIS AFTER installFex.sh

# download tool chain
wget https://github.com/mstorsjo/llvm-mingw/releases/download/20251007/llvm-mingw-20251007-msvcrt-ubuntu-22.04-x86_64.tar.xz -P ~/sys
tar -xvf ~/sys/llvm-mingw-20251007-msvcrt-ubuntu-22.04-x86_64.tar.xz -C ~/sys

TOOLCHAIN_PATH=$(realpath ~/sys/llvm-mingw-20251007-msvcrt-ubuntu-22.04-x86_64)

echo $TOOLCHAIN_PATH

if ! grep -q "$TOOLCHAIN_PATH" ~/.bashrc; then
  echo "export PATH=\"$TOOLCHAIN_PATH/bin:\$PATH\"" >> ~/.bashrc
fi
source ~/.bashrc

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



