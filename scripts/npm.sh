#!/bin/bash
source $PWD/scripts/helpers.sh

NVM_VERSION=$(nvm --version)
NPM_USER=$(npm whoami)

print "NVM Version: $NVM_VERSION"
if [ -z "$NPM_USER" ] ; then
  print "Initiating npm login"
  npm login
else
  print "Logged in as $NPM_USER"
fi

print "Installing globals"

npm i -g eslint eslint-config-rizowski
