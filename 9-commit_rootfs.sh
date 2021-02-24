#!/bin/bash -ex

TOS_ROOTFS=/var/cache/tos-builder/rootfs
TOS_VERSION=tos21

KERNEL_IMAGE_PATH=$(ls ${TOS_ROOTFS}/boot/vmlinuz*)
KERNEL_IMAGE_BASENAME=$(basename ${KERNEL_IMAGE_PATH})
KERNEL_VERSION=$(echo ${KERNEL_IMAGE_BASENAME} | cut -c 9-)

OSTREE_COMMIT_ROOTFS=/var/cache/tos-builder/commit_rootfs
OSTREE_LOCAL_REPO=/var/cache/tos-builder/ostree/repo
OSTREE_COMMIT_BRANCH=$1

# 1. create dirs
sudo mkdir -p ${OSTREE_COMMIT_ROOTFS}
sudo mkdir -p ${OSTREE_LOCAL_REPO}

# 2. copy current usr directory
sudo cp -r ${TOS_ROOTFS}/usr ${OSTREE_COMMIT_ROOTFS}/

# boot 관련 이미지 copy
sudo cp ${TOS_ROOTFS}/boot/vmlinuz-${KERNEL_VERSION} ${OSTREE_COMMIT_ROOTFS}/usr/lib/modules/${KERNEL_VERSION}/vmlinuz
sudo chmod 755 ${OSTREE_COMMIT_ROOTFS}/usr/lib/modules/${KERNEL_VERSION}/vmlinuz
sudo cp ${TOS_ROOTFS}/boot/initramfs-${KERNEL_VERSION}.img ${OSTREE_COMMIT_ROOTFS}/usr/lib/modules/${KERNEL_VERSION}/initramfs.img
sudo chmod 644 ${OSTREE_COMMIT_ROOTFS}/usr/lib/modules/${KERNEL_VERSION}/initramfs.img
sudo cp ${TOS_ROOTFS}/boot/System.map-${KERNEL_VERSION} ${OSTREE_COMMIT_ROOTFS}/usr/lib/modules/${KERNEL_VERSION}/System.map
sudo chmod 600 ${OSTREE_COMMIT_ROOTFS}/usr/lib/modules/${KERNEL_VERSION}/System.map
sudo cp ${TOS_ROOTFS}/boot/config-${KERNEL_VERSION} ${OSTREE_COMMIT_ROOTFS}/usr/lib/modules/${KERNEL_VERSION}/config

# 3. copy current etc directory
sudo cp -r /etc ${OSTREE_COMMIT_ROOTFS}/usr/

# 3. others
mkdir ${OSTREE_COMMIT_ROOTFS}/boot
mkdir ${OSTREE_COMMIT_ROOTFS}/dev
mkdir ${OSTREE_COMMIT_ROOTFS}/mnt
mkdir ${OSTREE_COMMIT_ROOTFS}/proc
mkdir ${OSTREE_COMMIT_ROOTFS}/run
mkdir ${OSTREE_COMMIT_ROOTFS}/srv
mkdir ${OSTREE_COMMIT_ROOTFS}/sys
mkdir ${OSTREE_COMMIT_ROOTFS}/sysroot
mkdir ${OSTREE_COMMIT_ROOTFS}/lost+found
mkdir ${OSTREE_COMMIT_ROOTFS}/.cache
mkdir ${OSTREE_COMMIT_ROOTFS}/var
mkdir -m 1777 ${OSTREE_COMMIT_ROOTFS}/tmp

cd ${OSTREE_COMMIT_ROOTFS}

ln -s ./usr/bin ${OSTREE_COMMIT_ROOTFS}/bin
ln -s ./usr/sbin ${OSTREE_COMMIT_ROOTFS}/sbin
ln -s ./usr/lib ${OSTREE_COMMIT_ROOTFS}/lib
ln -s ./usr/lib32 ${OSTREE_COMMIT_ROOTFS}/lib32
ln -s ./usr/lib64 ${OSTREE_COMMIT_ROOTFS}/lib64
ln -s ./usr/libx32 ${OSTREE_COMMIT_ROOTFS}/libx32
ln -s ./var/home ${OSTREE_COMMIT_ROOTFS}/home
ln -s ./run/media ${OSTREE_COMMIT_ROOTFS}/media
ln -s ./var/opt ${OSTREE_COMMIT_ROOTFS}/opt
ln -s ./var/roothome ${OSTREE_COMMIT_ROOTFS}/root

# 3. commit rootfs
sudo ostree init --repo=${OSTREE_LOCAL_REPO}
sudo ostree commit --repo=${OSTREE_LOCAL_REPO} --branch=${TOS_VERSION}-${OSTREE_COMMIT_BRANCH} ${OSTREE_COMMIT_ROOTFS}/


