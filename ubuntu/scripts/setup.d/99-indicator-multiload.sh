#!/bin/bash -ex

pip3 install --upgrade gnome-extensions-cli

sudo apt install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor

gnome-extensions-cli install "system-monitor-next@paradoxxx.zero.gmail.com"
