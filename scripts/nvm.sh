#!/bin/bash
source $PWD/scripts/helpers.sh

load_nvm

if ! command_exists nvm ; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | zsh

  load_nvm

  nvm i 8.10
  nvm i 6.10
  nvm alias default 8
fi
