#!/bin/bash

P530=$(dmidecode |grep "P530-K.AE22B")

if [[ -n "$P530" ]]; then
	# Fix backlight
	sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=vendor"/' /etc/default/grub 
	update-grub

	# Disabled nvidia because it was giving problems after rebooting a fresh installation
	# apt-get install -y nvidia-prime nvidia-361
fi


