#!/bin/bash -ex
apt-get install -y eatmydata virtualbox zlib1g-dev mysql-server git \
  libxslt1-dev libxml2-dev libmysqlclient-dev libssl-dev \
  libreadline6-dev redis-server imagemagick gitk nginx s3cmd \
  libyaml-dev libqt5webkit5-dev rhino sendmail xvfb \
  virtualbox-guest-additions-iso

apt-get install -y libcurl3 libcurl3-gnutls

# Install rbenv
su -l `logname` <<'EOF'
ls ~/.rbenv || git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
ls ~/.rbenv/plugins/ruby-build || \
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
EOF

su -l `logname` <<'EOF'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

rbenv install 2.5.7
rbenv global 2.5.7
gem install bundler
EOF

# Docker
apt-get update
apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Add user to docker group
usermod -aG docker $SUDO_USER

curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Set mysql root password to ""
echo "use mysql; "\
"update user set authentication_string=password(''), plugin='mysql_native_password' where user='root';" | mysql -uroot --password=""
service mysql restart

# Virtual box extended
usermod -a -G vboxusers $SUDO_USER
# install extension pack (it needs user interaction)
apt-get install -y virtualbox-ext-pack
