#!/bin/bash
TARGET_FILE=/usr/share/X11/xorg.conf.d/20-intel.conf


if [ -x /sys/class/backlight/intel_backlight ]; then 
  cp ./templates/backlight.conf $TARGET_FILE
  echo "X session restart is required to fix backlight"
fi
