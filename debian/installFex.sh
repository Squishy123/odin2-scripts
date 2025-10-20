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

pip install meson --break-system

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

# configure fex
# install dependencies
sudo apt install -y debootstrap patchelf squashfs-tools

# need to add this to bashrc for certain commands necessary in chroot
if ! grep -q '/sbin:/bin' ~/.bashrc; then
    echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH' >> ~/.bashrc
fi

source ~/.bashrc

# fetch and extract ubuntu rootfs
wget "https://rootfs.fex-emu.gg/Ubuntu_24_04/2025-03-04/Ubuntu_24_04.sqsh" -P ~/.fex-emu/RootFS/ 
mkdir -p ~/.fex-emu/RootFS/Ubuntu_24_04
unsquashfs -d ~/.fex-emu/RootFS/Ubuntu_24_04 ~/.fex-emu/RootFS/Ubuntu_24_04.sqsh

# execute commands inside chroot to get drivers
cd ~/.fex-emu/RootFS/Ubuntu_24_04/ 


# have to rewrite the chroot command to allow us to pass in commands 
sed -i '/ChrootArgs\.append(os\.environ\['\''SHELL'\''\])/,+1c\
        if len(sys.argv) > 2:\
            ChrootArgs.extend(sys.argv[2:])\
        else:\
            ChrootArgs.append(os.environ['\''SHELL'\''])\
            ChrootArgs.append("-i")' chroot.py


./chroot.py chroot /bin/bash -c "dpkg --add-architecture i386 && apt-get update && apt install -y mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386"


