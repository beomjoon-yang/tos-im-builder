#!/bin/bash -ex

# Where the checkout of the tree goes
#TOS_SYSROOT=$(mktemp -d -p /var/tmp ostree-deploy.XXXXXXXXXX)
TOS_SYSROOT=/var/cache/tos-builder/sysroot

# Name of the OS for ostree deployment
TOS_VERSION=tos21

# The ostree remote URL in installed configuration
TOS_OSTREE_URL=http://192.168.8.173/ostree

# The ostree local repo
OSTREE_LOCAL_REPO=/var/cache/tos-builder/ostree/repo

# The ostree remote branch
OSTREE_COMMIT_BRANCH=${TOS_VERSION}-$1

REPOPATH=${TOS_SYSROOT}/ostree/repo
BOOT=${TOS_SYSROOT}/boot

sudo mkdir -p ${TOS_SYSROOT}

sudo ostree admin init-fs "${TOS_SYSROOT}"
sudo ostree admin --sysroot="${TOS_SYSROOT}" os-init ${TOS_VERSION}
#ostree --repo="${REPOPATH}" remote add ${TOS_VERSION} ${TOS_OSTREE_URL} \
#  ${TOS_VERSION}-${OSTREE_COMMIT_BRANCH}
sudo ostree --repo="${REPOPATH}" pull-local --disable-fsync \
  --remote=${TOS_VERSION} ${OSTREE_LOCAL_REPO} ${OSTREE_COMMIT_BRANCH}

# Basic bootloader setup
# Assume grub for all other architectures
sudo mkdir -p "${BOOT}"/grub
# This is entirely using Boot Loader Spec (bls). A more general
# grub.cfg is likely needed
cat > "${BOOT}"/grub/grub.cfg <<"EOF"
insmod blscfg
bls_import
set default='0'
EOF


# Deploy with root=UUID random
uuid=$(uuidgen)
kargs=(--karg=root=UUID=${uuid} --karg=rw --karg=splash \
    --karg=plymouth.ignore-serial-consoles --karg=quiet)
sudo ostree admin --sysroot="${TOS_SYSROOT}" deploy \
  --os=${TOS_VERSION} "${kargs[@]}" \
  ${TOS_VERSION}:${OSTREE_COMMIT_BRANCH}

# Now $TOS_SYSROOT is ready to be written to some disknstable
