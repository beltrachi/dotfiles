#!/bin/bash
if [! -f ~/.dotfiles_installed ]; then
    ~/.dotfiles/script/bootstrap
fi

for config_file in ~/.dotfiles/**/*.sh
do
  source $config_file
done

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

