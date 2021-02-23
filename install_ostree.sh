#!/bin/bash -ex

mkdir /root/git
cd /root/git

# ostree build
git clone https://github.com/ostreedev/ostree.git
cd ostree
git submodule update --init
env NOCONFIGURE=1 ./autogen.sh
./configure --prefix=/usr --with-dracut --with-curl --with-builtin-grub2-mkconfig
make
sudo make install

