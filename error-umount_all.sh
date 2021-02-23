#!/bin/bash -ex

TOS_BUILD_DIR=/var/cache/tos-builder

#umount all

sudo umount ${TOS_BUILD_DIR}/rootfs/dev
sudo umount ${TOS_BUILD_DIR}/rootfs/sys
sudo umount ${TOS_BUILD_DIR}/rootfs/proc



