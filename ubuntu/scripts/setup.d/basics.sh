#!/bin/bash
apt-get install -y git-core chromium-browser curl openssh-server pidgin build-essential indicator-multiload tree vim
update-rc.d ssh defaults

# Uninstall Apport Error Reporting in Ubuntu
apt-get purge apport
