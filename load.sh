#!/bin/bash
if [ ! -f ~/.dotfiles_installed ]; then
    ~/.dotfiles/script/bootstrap
fi

for config_file in ~/.dotfiles/**/*.sh
do
  if [[ $config_file = *"/ubuntu/"* ]] || [[ $config_file = *"/macos/"* ]]; then
    true # do nothing
  else
    source $config_file
  fi
done

# Load macos custom bash setup
$(uname -a | grep Darwin > /dev/null) && . ~/.dotfiles/macos/bash_specifics.sh

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

