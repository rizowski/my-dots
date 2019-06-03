#!/bin/bash
source $PWD/scripts/helpers.sh

FNM_VERSION="$(fnm --version)"
NPM_USER="$(npm whoami)"
NPM_VERSION="$(npm --version)"

print "FNM Version: $FNM_VERSION"
print "NPM Version: $NPM_VERSION"

if [ -z "$NPM_USER" ] ; then
  print "Initiating npm login"
  npm login
else
  print "Logged in as $NPM_USER"
fi
