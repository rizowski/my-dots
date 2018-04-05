#!/bin/bash
source $PWD/scripts/helpers.sh

if ! command_exists brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

print "Updating and upgrading brews"
brew update
brew upgrade -y

brew bundle --global
brew link "git"

print "Cleaning up the mess..."
brew prune
brew cleanup
brew cask cleanup

echo "Setup brews and casks to auto update at startup?"
select result in Yes No
do
  if [ $result == 'Yes' ] ; then
    if ! [ -f /Library/LaunchDaemons/brew-update-schedule.plist ] ; then
      sudo ln -s $PWD/files/brew-update-schedule.plist /Library/LaunchDaemons
    else
      print "Auto update is already enabled"
    fi
  fi

  break;
done
