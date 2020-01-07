#!/bin/bash
source $PWD/scripts/helpers.sh

if ! command_exists brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf "Updating and upgrading brews"
brew update > /dev/null
printf "."
brew upgrade > /dev/null
printf "."

brew bundle --global > /dev/null
printf "."
brew link "git" > /dev/null 2>&1
echo " ✓"

printf "Cleaning up the mess"
brew cleanup > /dev/null
echo " ✓"
