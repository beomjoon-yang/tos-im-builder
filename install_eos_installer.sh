#!/bin/bash -ex

cd /root/git

# ostree build
git clone https://github.com/endlessm/eos-installer.git
cd eos-installer
./autogen.sh
./configure --prefix=/usr
make
sudo make install

