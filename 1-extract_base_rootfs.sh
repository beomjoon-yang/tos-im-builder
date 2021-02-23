#!/bin/bash -ex

TOS_BASE_ISO=$1
TOS_BUILD_DIR=/var/cache/tos-builder

#clean build directory if exists
sudo rm -rf ${TOS_BUILD_DIR}

sudo mkdir -p ${TOS_BUILD_DIR}/mnt
sudo mount -o loop $1 ${TOS_BUILD_DIR}/mnt

#sudo mkdir -p ${TOS_BUILD_DIR}/rootfs
sudo unsquashfs -f -d ${TOS_BUILD_DIR}/rootfs ${TOS_BUILD_DIR}/mnt/live/filesystem.squashfs


