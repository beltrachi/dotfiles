#!/bin/bash
sudo apt-get install -y pm-utils

sudo add-apt-repository ppa:linrunner/tlp -y
sudo apt-get update
sudo apt-get install -y tlp tlp-rdw
sudo tlp start
