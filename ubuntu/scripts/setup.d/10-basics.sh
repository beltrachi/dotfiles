#!/bin/bash

apt-get install -y git chromium-browser curl openssh-server pidgin \
  build-essential tree vim nautilus-dropbox \
  ttf-liberation vlc whois compizconfig-settings-manager \
  pepperflashplugin-nonfree gparted compiz-plugins keepassx nethogs \
  iftop network-manager-vpnc-gnome iotop gnome-shell-extension-system-monitor

update-rc.d ssh defaults

# Install flatpak
apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Fix encoding issues on 14.04
locale-gen en_US.UTF-8
locale-gen es_ES.UTF-8
dpkg-reconfigure locales

# Uninstall Apport Error Reporting in Ubuntu
apt-get purge apport

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Load preferences like keyboard shortcuts etc.
su - $SUDO_USER -c "dconf load / < ${DIR}/dconf.config"

# Update config for multiload
su - $SUDO_USER -c "dconf load /de/mh21/indicator-multiload/ < ${DIR}/dconf/indicator-multiload.conf"
