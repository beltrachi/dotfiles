#!/bin/bash
# Run vscode with current working dir or targets provided
# in background.
# Examples:
#   e ~/.bashrc     # Opens bashrc
#   e               # Opens current directory

# Mac vscodium binary is code
if $(which vscode 2> /dev/null); then
  true # Nothing to do.
else
  vscode () { code $@; }
fi

e () {
  echo $1
  if [[ -z $@ ]]; then
    # Opens cwd by default
    vscode . &
  else
    vscode $@ &
  fi
}
