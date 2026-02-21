#!/bin/bash 

sudo apt install -y \
  aubio-tools libaubio-dev \
  autoconf \
  automake \
  bison \
  libboost-all-dev \
  libcairo2-dev \
  libcairomm-1.0-dev \
  cmake \
  libcppunit-dev \
  curl libcurl4-openssl-dev \
  libexpat1-dev \
  libfftw3-dev \
  libflac-dev \
  flex \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  gettext \
  libglib2.0-dev \
  libglibmm-2.4-dev \
  gnome-common \
  yelp-tools \
  libgirepository1.0-dev \
  libharfbuzz-dev \
  intltool \
  itstool \
  libjpeg-dev \
  libarchive-dev \
  libffi-dev \
  libc6-dev \
  liblo-dev \
  libogg-dev \
  libpng-dev \
  libsamplerate0-dev \
  libsigc++-2.0-dev \
  libsndfile1-dev \
  libtool \
  libusb-1.0-0-dev \
  libvorbis-dev \
  libwebsockets-dev \
  libxml2-dev \
  libxslt1-dev \
  liblilv-dev \
  liblrdf-dev \
  lv2-dev \
  m4 \
  make \
  libnss3-dev \
  libopus-dev \
  libpango1.0-dev \
  libpangomm-1.4-dev \
  libpcre3-dev \
  libpixman-1-dev \
  pkg-config \
  libraptor2-dev \
  librasqal3-dev \
  python3-rdflib \
  libreadline-dev \
  librdf0-dev \
  librubberband-dev \
  libserd-dev \
  libsord-dev \
  libsratom-dev \
  libtag1-dev \
  tar \
  libncurses-dev \
  libtiff-dev \
  util-linux \
  uuid-dev \
   vamp-plugin-sdk libvamp-sdk2v5 libvamp-hostsdk3v5 \
  liblzma-dev \
  zlib1g-dev

cd ~/sys 

git clone git://git.ardour.org/ardour/ardour.git

cd ardour 

python3 waf configure
python3 waf
sudo python3 waf install

wget -O ardour-icon.png "https://avatars.githubusercontent.com/u/1402482?s=280&v=4"

mkdir -p "$HOME/.local/share/applications"

cat > "$HOME/.local/share/applications/ardour.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Ardour
Comment=Launch Ardour
Exec=bash -lc "/usr/local/bin/ardour9"
Icon=$HOME/sys/ardour/ardour-icon.png
Terminal=false
Categories=Audio;
StartupNotify=true
EOF
