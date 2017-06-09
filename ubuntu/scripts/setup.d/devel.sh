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

# Install rbenv
su -l `logname` <<'EOF'
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
source ~/.bashrc
rbenv install 2.1.2
rbenv global 2.1.2
gem install bundler
EOF

exit 1
# Nodejs
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install -y python-software-properties python g++ make nodejs
npm install coffee-script -g

[ -e /usr/lib/apt/methods/https ] || {
  apt-get update
  apt-get install apt-transport-https
}

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

sh -c "echo deb https://get.docker.com/ubuntu docker main\
> /etc/apt/sources.list.d/docker.list"

apt-get update
apt-get install lxc-docker
# TODO: add user to docker group

curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
