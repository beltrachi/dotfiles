# dotfiles

Based on (but not forked) https://github.com/holman/dotfiles without the zsh dependency.

## install

Run this:

```sh
git clone https://github.com/beltrachi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`, though.

You'll also want to change `git/gitconfig.symlink`, which will set you up as
committing as me. You probably don't want that.

Read Holman README for more info: https://github.com/holman/dotfiles

## Setup

Compilation of commands to run when I'm getting my laptop ready.

Usage:
```
cd ubuntu/setup
./setup.sh
```

For macOS:
```
cd macos/setup
./setup.sh
```