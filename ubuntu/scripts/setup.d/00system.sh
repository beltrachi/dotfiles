#!/bin/bash

P530=$(dmidecode |grep "P530-K.AE22B")

if [[ -n "$P530" ]]; then

	apt-get install -y nvidia-375

	# Fix backlight
	sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=vendor"/' /etc/default/grub 
	update-grub

	# When usb wifi detected, disable internal wifi device.
	HAS_USB_WIFI=$(lsusb | grep "RTL8188CUS")
	if [[ -n "$HAS_USB_WIFI" ]]; then
		# Disable internal interface
		LINE="iface wlp8s0 inet manual"
		FILE="/etc/network/interfaces"
		grep -q -F "$LINE" $FILE || echo "$LINE" >> $FILE
		service network-manager restart
	fi
fi


