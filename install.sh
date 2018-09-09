#!/bin/sh

# Install packages
apt update
apt -y install git gcc bc rsync
apt -y apache2 php php-zip php-mbstring
apt -y install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev
apt -y install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
apt -y install gcc-arm-linux-gnueabi g++-arm-linux-gnueabi

# Create an user
adduser acme

# Configure apache
cp 000-default.conf /etc/apache2/sites-available/
ln -s /home/acme/builder /home/acme/html
systemctl restart apache2

# Install Codiad
su acme
(cd /home/acme/builder && git clone https://github.com/Codiad/Codiad.git)
sudo chmod -R 777 /home/acme/builder

 