#!/bin/bash -ex

TOS_BUILD_DIR=/var/cache/tos-builder

sudo cp install_flatpak.sh ${TOS_BUILD_DIR}/rootfs/root
sudo chroot "${TOS_BUILD_DIR}/rootfs" bash -c /root/install_flatpak.sh