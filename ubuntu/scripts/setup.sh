#!/bin/bash

# Enable debugging to notice when some installation fails
set -ex

if [ "$UID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# run all setup.d scripts
for file in ./setup.d/*.sh
do
  bash $file
done

