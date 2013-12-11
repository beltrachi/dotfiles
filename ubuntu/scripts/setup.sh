#!/bin/bash
if [ "$UID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# TODO: run all setup.d scripts
for file in setup.d/*.sh
do
  $config_file
done

