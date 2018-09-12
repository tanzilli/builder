#!/bin/sh

# Installazione dei pacchetti comuni

apt update
apt -y install gcc bc rsync curl
apt -y apache2 php php-zip php-mbstring
apt -y install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev
apt -y install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
apt -y install gcc-arm-linux-gnueabi g++-arm-linux-gnueabi

 