#!/bin/bash -ex

TOS_BUILD_DIR=/var/cache/tos-builder

sudo cp ostree.conf ${TOS_BUILD_DIR}/rootfs/root
sudo cp create_initramfs.sh ${TOS_BUILD_DIR}/rootfs/root

sudo chroot "${TOS_BUILD_DIR}/rootfs" bash -c /root/create_initramfs.sh
