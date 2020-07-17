#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

./brew.sh
./.macos

echo "Installation complete. Now we're going to execute some apps to be correctly setted up"

echo "Open spotlight (Cmd + Space) and execute Spectacle. Follow the instructions."

function press_any_key(){
    read -n1 -r -p "Press any key to continue..." key
}
press_any_key

echo "Open spotlight and execute Karabiner-elements"
press_any_key

echo "Open spotlight and execute MenuMeters"
press_any_key
