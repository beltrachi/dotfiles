#!/bin/bash
apt-get install -y eatmydata virtualbox zlib1g-dev mysql-server git \
  libxslt-dev libxml2-dev qt-sdk libmysqlclient-dev libssl-dev libreadline6 \
  libreadline6-dev redis-server imagemagick gitk nginx s3cmd \
  libyaml-dev libqt5webkit5-dev rhino sendmail xvfb

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

# Docker
apt-get update
apt-get install -y apt-transport-https ca-certificates

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

DISTRO=$(lsb_release -c -s)
echo deb https://apt.dockerproject.org/repo ubuntu-$DISTRO main > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get purge lxc-docker
sudo apt-get install -y linux-image-extra-$(uname -r)
sudo apt-get install -y docker-engine
sudo service docker start

# Start docker on boot
sudo systemctl enable docker

# Add machine users to docker group
for USERNAME in $(ls /home/* -d  |grep -oE "([^/]*)$")
do
    sudo usermod -aG docker $USERNAME
done

curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
