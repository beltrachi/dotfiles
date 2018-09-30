#!/bin/bash
# Fixed command from hipchat page because bionic release is still not ready. Workardound is to use xenial
echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client xenial main" > /etc/apt/sources.list.d/atlassian-hipchat4.list
wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | sudo apt-key add -

apt-get update
apt-get install -y hipchat4
