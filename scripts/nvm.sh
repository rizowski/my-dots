#!/bin/bash
source $PWD/scripts/helpers.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if ! command_exists nvm ; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | zsh
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm i 8.9
  nvm i 6.10
  nvm alias default 8
fi
