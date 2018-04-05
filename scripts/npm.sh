#!/bin/bash
source $PWD/scripts/helpers.sh

load_nvm

NVM_VERSION="$(nvm --version)"
NPM_USER="$(npm whoami)"
NPM_VERSION="$(npm --version)"

print "NVM Version: $NVM_VERSION"
print "NPM Version: $NPM_VERSION"

if [ -z "$NPM_USER" ] ; then
  print "Initiating npm login"
  npm login
else
  print "Logged in as $NPM_USER"
fi
