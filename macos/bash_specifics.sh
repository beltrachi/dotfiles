#!/bin/bash

# Redirect call to terminal notifier
function notify-send(){
  terminal-notifier -title Command -subtitle "$2" -message "$1"

}
