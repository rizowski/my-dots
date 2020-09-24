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
