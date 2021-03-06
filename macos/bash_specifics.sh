#!/bin/bash

# Redirect call to terminal notifier
function notify-send(){
  terminal-notifier -title Command -subtitle "$2" -message "$1"

}
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
source /usr/local/etc/bash_completion.d/git-prompt.sh

alias "psauxf"="ps -Ao user,pid,%cpu,%mem,vsz,rss,tt,stat,start,time,command"

# xdg-open linux command adapter for macos
function xdg-open(){
  open $1
}
