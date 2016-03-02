#!/bin/bash
apt-get install -y eatmydata virtualbox zlib1g-dev mysql-server git \
  libxslt-dev libxml2-dev qt-sdk libmysqlclient-dev libssl-dev libreadline6 \
  libreadline6-dev redis-server imagemagick gitk nginx s3cmd \
  libyaml-dev libqt5webkit5-dev rhino sendmail

apt-get install -y libcurl3 libcurl3-gnutls libcurl4-openssl-dev

if [[ ! $(command -v vagrant) ]]; then
  # Get last version available
  LAST_URL=`curl https://dl.bintray.com/mitchellh/vagrant/ |grep -o "http.*.deb" |sort -V|tail -n 1`
  if [[ -n "$LAST_URL" ]]; then
      wget -O /tmp/vagrant_x86_64.deb $LAST_URL
      dpkg -i /tmp/vagrant_x86_64.deb
  fi
fi

# Execute template created from
# curl -sL https://deb.nodesource.com/setup_4.x > templates/nodesetup_4.sh
# saved as a template to review first what it does.
sudo ./templates/nodesetup_4.sh
npm install coffee-script -g

[ -e /usr/lib/apt/methods/https ] || {
  apt-get update
  apt-get install -y apt-transport-https
}

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

sh -c "echo deb https://get.docker.com/ubuntu docker main\
> /etc/apt/sources.list.d/docker.list"

apt-get update
apt-get install lxc-docker

curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
