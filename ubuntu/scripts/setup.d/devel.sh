#!/bin/bash
apt-get install -y eatmydata virtualbox zlib1g-dev mysql-server git \
  libxslt-dev libxml2-dev qt-sdk libmysqlclient-dev libssl-dev libreadline6 \
  libreadline6-dev redis-server imagemagick gitk nginx s3cmd \
  libyaml-dev

if [[ ! $(command -v vagrant) ]]; then
  wget -O /tmp/vagrant_1.4.0_x86_64.deb https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.0_x86_64.deb
  dpkg -i /tmp/vagrant_1.4.0_x86_64.deb
fi

sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make nodejs
