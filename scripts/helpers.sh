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

directory_exists(){
  if [ -d "$HOME/$1" ] ; then
    true
  else
    false
  fi
}

update_gitrepo() {
  local name=$(basename $1)
  echo "Would you like to update $name (Y/n)?"
  select result in Yes No
  do
    if [[ $result =~ ^[Yy]([Ee][Ss])?$ ]] || [[ -z $result ]]; then
      echo "Updating $1..."
      git -C $1 pull > /dev/null
      echo
    fi
    break;
  done
}

install_or_update() {
  local name=$(basename $2)
  local DIRECTORY="$1/$name"

  if [ ! -d "$DIRECTORY" ]; then
    git clone --depth 1 $2 $DIRECTORY
    print "$name installed"
  else
    update_gitrepo $DIRECTORY
  fi
}
