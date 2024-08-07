#!/bin/bash -ex

sudo apt-get update
sudo apt-get install -y virtualbox zlib1g-dev git \
  libxslt1-dev libxml2-dev libssl-dev \
  libreadline6-dev imagemagick gitk nginx s3cmd \
  libyaml-dev libqt5webkit5-dev rhino sendmail xvfb \
  virtualbox-guest-additions-iso libcurl3-gnutls

# Install rbenv
ls ~/.rbenv || git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
ls ~/.rbenv/plugins/ruby-build || \
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Virtual box extended
sudo usermod -a -G vboxusers $USERNAME
# install extension pack (it needs user interaction)
sudo apt-get install -y virtualbox-ext-pack

snap install codium --classic
