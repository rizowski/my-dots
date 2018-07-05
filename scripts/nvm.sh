#!/bin/bash
source $PWD/scripts/helpers.sh

function getLatestTag (){
  curl -s https://api.github.com/repos/creationix/nvm/releases/latest | grep "\"name\":" | cut -d '"' -f 4
}

echo "installing or updating nvm..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/$(getLatestTag)/install.sh | zsh > /dev/null 2>&1

load_nvm

nvm i 8.10.0
nvm i 6.10.3
nvm alias default 8
nvm use default

npm config delete prefix
npm config set prefix $NVM_DIR/versions/node/v8.10.0
