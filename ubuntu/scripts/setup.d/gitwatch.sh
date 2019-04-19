#!/bin/bash

apt-get install -y inotify-tools

mkdir ~/apps

cd ~/apps
git clone https://github.com/nevik/gitwatch.git

mkdir ~/bin
ln -s ~/apps/gitwatch/gitwatch.sh ~/bin/gitwatch.sh 
