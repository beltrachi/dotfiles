#!/bin/bash
apt-get install -y git-core chromium-browser curl openssh-server pidgin \
  build-essential indicator-multiload tree vim nautilus-dropbox \
  ttf-liberation vlc whois compizconfig-settings-manager \
  pepperflashplugin-nonfree gparted compiz-plugins keepassx nethogs \
  iftop network-manager-vpnc-gnome iotop

update-rc.d ssh defaults

# Fix encoding issues on 14.04
locale-gen en_US.UTF-8
locale-gen es_ES.UTF-8
dpkg-reconfigure locales

# Uninstall Apport Error Reporting in Ubuntu
apt-get purge apport
