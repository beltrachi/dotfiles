#!/bin/bash

apt-get install -y git chromium-browser curl openssh-server pidgin \
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

# To switch left ctrl with left alt (For MacOS keyb partial compatibility)
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swap_lalt_lctl']"

# Configure keys like macOS keyboard.
SET_KB="gsettings set org.gnome.desktop.wm.keybindings"

$SET_KB switch-applications "['<Primary>Tab']"
$SET_KB switch-applications-backward "['<Primary><Shift>Tab']"

$SET_KB switch-to-workspace-1 "['<Primary><Alt>less']"
$SET_KB switch-to-workspace-2 "['<Primary><Alt>z']"
$SET_KB switch-to-workspace-4 "['<Primary><Alt>c']"
$SET_KB switch-to-workspace-3 "['<Primary><Alt>x']"
