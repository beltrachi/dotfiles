#!/bin/bash
sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt-get update
sudo apt-get install -y emacs-snapshot

wget https://github.com/bbatsov/prelude/raw/master/utils/installer.sh -O - | sh
