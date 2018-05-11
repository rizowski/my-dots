#!/bin/bash
source $PWD/scripts/helpers.sh

if ! command_exists brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf "Updating and upgrading brews"
brew update > /dev/null
printf "."
brew upgrade -y > /dev/null
printf "."

brew bundle --global > /dev/null
printf "."
brew link "git" > /dev/null 2>&1
echo " ✓"

printf "Cleaning up the mess"
brew prune > /dev/null
printf "."
brew cleanup > /dev/null
printf "."
brew cask cleanup > /dev/null
echo " ✓"

clear
echo "Auto update brews and casks at startup?"
select result in Yes No
do
  if [[ $result =~ ^[Yy]([Ee][Ss])?$ ]] || [[ -z $result ]]; then
    if ! [ -f /Library/LaunchDaemons/brew-update-schedule.plist ] ; then
      sudo ln -s $PWD/files/brew-update-schedule.plist /Library/LaunchDaemons
    else
      print "Auto update is already enabled"
    fi
  fi

  break;
done
