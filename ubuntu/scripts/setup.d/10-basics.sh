#!/bin/bash -ex

sudo apt-get install -y git chromium-browser curl openssh-server pidgin \
  build-essential tree vim nautilus-dropbox \
  vlc whois compizconfig-settings-manager \
  gparted compiz-plugins keepassx nethogs \
  iftop network-manager-vpnc-gnome iotop

sudo update-rc.d ssh defaults

# Fix encoding issues on 14.04
sudo locale-gen en_US.UTF-8
sudo locale-gen es_ES.UTF-8
sudo dpkg-reconfigure locales

# Uninstall Apport Error Reporting in Ubuntu
sudo apt-get purge -y apport

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p ~/.config/dconf
# Load preferences like keyboard shortcuts etc.
dconf load / < ${DIR}/dconf.config

gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true
