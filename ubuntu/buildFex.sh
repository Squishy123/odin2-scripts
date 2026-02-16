#!/bin/bash 

# install dependencies
sudo apt update 
sudo apt install -y python3 \
  python3-pip \
  git \
  cmake \
  ninja-build \
  pkgconf \
  ccache \
  clang \
  llvm \
  lld \
  binfmt-support \
  libssl-dev \
  python3-setuptools \
  g++-x86-64-linux-gnu \
  libgcc-12-dev-i386-cross \
  libgcc-12-dev-amd64-cross \
  nasm \
  python3-clang \
  libstdc++-12-dev-i386-cross \
  libstdc++-12-dev-amd64-cross \
  libstdc++-12-dev-arm64-cross \
  squashfs-tools \
  squashfuse \
  libc-devtools \
  libc6-dev-i386-amd64-cross \
  lib32stdc++-12-dev-amd64-cross \
  qtdeclarative5-dev \
  qml-module-qtquick-controls \
  qml-module-qtquick-controls2 \
  qml-module-qtquick-dialogs

sudo apt purge -y meson
sudo pip install meson --break-system

export PATH="$HOME/.local/bin:$PATH"

cd ~ 
mkdir -p sys && cd sys 

# build fex
git clone --recurse-submodules https://github.com/FEX-Emu/FEX.git
cd FEX
mkdir Build
cd Build
CC=clang CXX=clang++ cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_LINKER=lld -DENABLE_LTO=True -DBUILD_TESTING=False -DENABLE_ASSERTIONS=False -G Ninja ..
ninja

sudo ninja install
sudo ninja binfmt_misc

