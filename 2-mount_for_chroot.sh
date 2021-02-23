#!/bin/bash -ex

TOS_BUILD_DIR=/var/cache/tos-builder

#bind mounts
sudo mkdir -p ${TOS_BUILD_DIR}/rootfs/dev
sudo mkdir -p ${TOS_BUILD_DIR}/rootfs/sys
sudo mkdir -p ${TOS_BUILD_DIR}/rootfs/proc

sudo mount --bind /dev ${TOS_BUILD_DIR}/rootfs/dev
sudo mount --bind /sys ${TOS_BUILD_DIR}/rootfs/sys
sudo mount --bind /proc ${TOS_BUILD_DIR}/rootfs/proc

sudo cp chroot_1-env_setup.sh ${TOS_BUILD_DIR}/rootfs/root
sudo chroot "${TOS_BUILD_DIR}/rootfs" bash -c /root/chroot_1-env_setup.sh
