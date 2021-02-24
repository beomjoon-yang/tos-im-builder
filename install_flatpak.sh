#!/bin/bash -ex

cd /root/git

# flatpak build
echo "deb http://deb.debian.org/debian buster-backports main" >> /etc/apt/sources.list
apt update
git clone https://github.com/flatpak/flatpak.git
cd flatpak
sudo apt -t buster-backports install libostree-dev libfuse-dev -y
sudo apt install python3-pip autoconf automake libtool pkg-config m4 gtk-doc-tools autopoint elfutils -y
sudo apt build-dep flatpak -y
sudo apt install flatpak-builder -y
pip3 install pyparsing

./autogen.sh
./configure
make -j
make install -j

# repo 
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# gnome-plugin
sudo apt install gnome-software-plugin-flatpak