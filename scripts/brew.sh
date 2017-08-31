source ./helpers.sh

if ! command_exists brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew tap caskroom/cask
brew tap Homebrew/bundle
brew tap 'homebrew/completions'
brew tap 'homebrew/core'
brew upgrade -y

brew bundle
brew link git
