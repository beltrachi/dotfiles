#!/bin/bash -ex
apt-get install -y eatmydata virtualbox zlib1g-dev mysql-server git \
  libxslt1-dev libxml2-dev libmysqlclient-dev libssl-dev \
  libreadline-dev redis-server imagemagick gitk nginx s3cmd \
  libyaml-dev libqt5webkit5-dev rhino sendmail xvfb \
  virtualbox-guest-additions-iso

apt-get install -y libcurl3 libcurl3-gnutls libcurl4-openssl-dev

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

# Nodejs
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
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

DISTRO=$(lsb_release -c -s)
echo deb https://apt.dockerproject.org/repo ubuntu-$DISTRO main > /etc/apt/sources.list.d/docker.list

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

apt-get update
apt-cache policy docker-ce
sudo apt install docker-ce

# Add machine users to docker group
for USERNAME in $(ls /home/* -d  |grep -oE "([^/]*)$")
do
    sudo usermod -aG docker $USERNAME
done

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Set mysql root password to ""
echo "use mysql; "\
"update user set authentication_string=password(''), plugin='mysql_native_password' where user='root';" | mysql -uroot --password=""
service mysql restart

# Virtual box extended
sudo usermod -a -G vboxusers $(whoami)
# install extension pack (it needs user interaction)
sudo apt-get install -y virtualbox-ext-pack
