#!/bin/bash
apt-get install -y eatmydata virtualbox zlib1g-dev mysql-server git \
  libxslt-dev libxml2-dev qt-sdk libmysqlclient-dev libssl-dev libreadline6 \
  libreadline6-dev redis-server imagemagick gitk nginx s3cmd \
  libyaml-dev libqt5webkit5-dev

apt-get install -y libcurl3 libcurl3-gnutls libcurl4-openssl-dev

if [[ ! $(command -v vagrant) ]]; then
  # Get last version available
  LAST_URL=`curl https://dl.bintray.com/mitchellh/vagrant/ |grep -o "http.*.deb" |sort -V|tail -n 1`
  if [[ -n "$LAST_URL" ]]; then
      wget -O /tmp/vagrant_x86_64.deb $LAST_URL
      dpkg -i /tmp/vagrant_x86_64.deb
  fi
fi

add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y python-software-properties python g++ make nodejs
npm install coffee-script -g
