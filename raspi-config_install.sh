#!/bin/sh

# Check if root
if [ "$(whoami)" != "root" ]; then
  echo "Sorry, you are not root. You must type: sudo sh install.sh"
  exit
fi

# Check if Raspberry Pi repository is already added
if ! grep -q "deb http://archive.raspberrypi.org/debian/ buster main" /etc/apt/sources.list; then
  echo "deb http://archive.raspberrypi.org/debian/ buster main" >> /etc/apt/sources.list
fi

# Check if Raspberry Pi Foundation public key is already imported
if ! apt-key list | grep -q "7FA3303E"; then
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7FA3303E
fi

# Update package list
apt update

# Check if raspi-config is already installed
if [ $(dpkg-query -W -f='${Status}' raspi-config 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
  echo "Raspi-config is already installed, try upgrading it within raspi-config..."
else
  apt install -y sudo libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils raspi-config
  echo "Raspi-config is now installed. You can run it by typing: sudo raspi-config"
fi
