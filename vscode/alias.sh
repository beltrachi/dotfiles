#!/bin/bash
# Run vscode with current working dir or targets provided
# in background.
# Examples:
#   e ~/.bashrc     # Opens bashrc
#   e               # Opens current directory

e () {
  echo $1
  CODIUM_BIN=$(which vscode codium code | head -n 1)
  if [[ -z $@ ]]; then
    # Opens cwd by default
    $CODIUM_BIN . &
  else
    $CODIUM_BIN $@ &
  fi
}
