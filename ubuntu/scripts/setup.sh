#!/bin/bash -ex

if [ "$UID" -e 0 ]
  then echo "Please run as regular user"
  exit
fi

# run all setup.d scripts
for file in ./setup.d/*.sh
do
  echo "Executing $file"
  bash -x $file
done

sudo apt autoremove -y
