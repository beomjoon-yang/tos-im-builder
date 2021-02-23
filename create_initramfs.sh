#!/bin/bash -ex

# create initramfs with dracut
DRACUT_OSTREE_CONF=ostree.conf

KERNEL_IMAGE_PATH=$(ls /boot/vmlinuz*)
KERNEL_IMAGE_BASENAME=$(basename ${KERNEL_IMAGE_PATH})
KERNEL_VERSION=$(echo ${KERNEL_IMAGE_BASENAME} | cut -c 9-)

ls

sudo cp /root/${DRACUT_OSTREE_CONF} /etc/dracut.conf.d/
sudo dracut /boot/initramfs-${KERNEL_VERSION}.img ${KERNEL_VERSION} 


