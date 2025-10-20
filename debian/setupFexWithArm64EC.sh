#!/bin/bash

# RUN THIS AFTER installFex.sh, installWineWithArm64EC

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



