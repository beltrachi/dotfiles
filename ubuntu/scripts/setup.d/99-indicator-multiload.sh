#!/bin/bash -ex

pipx install gnome-extensions-cli --system-site-packages

sudo apt install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor

bash -li -c "gnome-extensions-cli install 'system-monitor-next@paradoxxx.zero.gmail.com'"
