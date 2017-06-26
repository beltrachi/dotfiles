#!/bin/bash
# Run emacs with current working dir or targets provided
# in background.
# Examples:
#   e ~/.bashrc     # Opens bashrc
#   e               # Opens current directory
e () {
  echo $1
  if [[ -z $@ ]]; then
    # Opens cwd by default
    emacs . &
  else
    emacs $@ &
  fi
}
