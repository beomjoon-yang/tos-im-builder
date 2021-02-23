#!/bin/bash -ex

# update apt
sudo apt update

# install essential packages
sudo apt install autoconf libtool libglib2.0-dev libgpgme-dev \
       bison liblzma-dev e2fslibs-dev libfuse-dev libsystemd-dev dracut \
       libsoup2.4-dev libcurl4-gnutls-dev git intltool autoconf-archive \
       libgnome-desktop-3-dev libudisks2-dev -y
