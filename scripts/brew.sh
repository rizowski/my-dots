#!/bin/bash
source $PWD/scripts/helpers.sh

if ! command_exists brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade -y

brew bundle --global
brew link "git"
brew prune
brew cleanup
brew cask cleanup
# brew bundle cleanup --force

echo "Setting brew auto update job at login..."
sudo ln -s $PWD/files/brew-update-schedule.plist /Library/LaunchDaemons
