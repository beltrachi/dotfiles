#!/bin/bash
# Run vscode with current working dir or targets provided
# in background.
# Examples:
#   e ~/.bashrc     # Opens bashrc
#   e               # Opens current directory

# Mac vscodium binary is code
if which vscode 2>&1 > /dev/null; then
  true # Nothing to do.
else
  if which code 2>&1 > /dev/null; then
    vscode () { code $@; }
  elif which codium 2>&1 > /dev/null; then
    vscode () { codium $@; }
  fi
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
