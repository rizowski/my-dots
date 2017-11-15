#!/bin/bash
command_exists(){
  type "$1" &> /dev/null ;
}

print (){
  echo "$1"
}

file_exists(){
  if [ -h "$HOME/$1" ] || [ -f "$HOME/$1" ] ; then
    true
  else
    false
  fi
}

# if ! command_exists nvm ; then
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# fi
