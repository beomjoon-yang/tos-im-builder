#!/bin/bash -ex

TOS_BUILD_DIR=/var/cache/tos-builder


sudo cp sources.list ${TOS_BUILD_DIR}/rootfs/etc/apt/sources.list
sudo cp env_setup.sh ${TOS_BUILD_DIR}/rootfs/root

sudo chroot "${TOS_BUILD_DIR}/rootfs" bash -c /root/env_setup.sh

