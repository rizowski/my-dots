#!/bin/bash
source $PWD/scripts/helpers.sh

link_file(){
  print "Linking $1"
  ln -s $PWD/files/$1 $HOME/$1
}

copy_file(){
  print "Copying $1"
  cp $PWD/files/$1 $HOME/$1
}

link_dot_file(){
  print "Linking $1"
  ln -s $PWD/files/$1 $HOME/.$1
}

if ! file_exists .Brewfile ; then
  link_dot_file Brewfile
fi

if ! file_exists .profile ; then
  link_dot_file profile
fi

if ! file_exists .zshrc ; then
  link_dot_file zshrc
fi

if ! file_exists .gitconfig ; then
  link_dot_file gitconfig
fi

if ! file_exists .gitconfig-work ; then
  link_dot_file gitconfig-work
fi

if ! file_exists .editorconfig ; then
  link_dot_file editorconfig
fi

if ! file_exists .eslintrc ; then
  link_dot_file eslintrc
fi
