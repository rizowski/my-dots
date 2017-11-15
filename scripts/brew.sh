#!/bin/bash
source $PWD/scripts/helpers.sh

if ! command_exists brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
# brew tap "Homebrew/bundle"
brew upgrade -y

brew bundle
brew link "git"
brew prune
# brew bundle cleanup --force
