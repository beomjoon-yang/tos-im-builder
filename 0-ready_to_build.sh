#!/bin/bash -ex

# update apt
sudo apt update

# install essential packages
sudo apt install autoconf libtool libglib2.0-dev libgpgme-dev \
       bison liblzma-dev e2fslibs-dev libfuse-dev libsystemd-dev dracut \
       libsoup2.4-dev libcurl4-gnutls-dev git intltool autoconf-archive \
       libgnome-desktop-3-dev libudisks2-dev -y

# ostree build
mkdir -p /var/cache/tos-builder/git
cd /var/cache/tos-builder/git

git clone https://github.com/ostreedev/ostree.git
cd ostree
git submodule update --init
env NOCONFIGURE=1 ./autogen.sh
./configure --prefix=/usr --with-dracut --with-curl --with-builtin-grub2-mkconfig
make
sudo make install

