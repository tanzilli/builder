#!/bin/sh
apt update
apt install git
apt install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev
apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
apt-get install gcc-arm-linux-gnueabi g++-arm-linux-gnueabi

