#!/bin/bash
source $PWD/scripts/helpers.sh

if ! command_exists nvm ; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
fi
