#!/bin/bash
source $PWD/scripts/helpers.sh

echo "Installing personal files"
sh $PWD/scripts/personal-settings.sh
clear

echo "Installing brew"
sh $PWD/scripts/brew.sh
clear

echo "Installing nvm"
sh $PWD/scripts/nvm.sh
clear

echo "Installing zsh"
sh $PWD/scripts/zsh.sh
clear

# echo "installing mac settings"
# echo "Skipping Mac settings"
# sh $PWD/scripts/mac-settings.sh
# clear

echo "Setting up npm"
sh $PWD/scripts/npm.sh
clear

echo "Setting up yarn"
sh $PWD/scripts/yarn.sh
clear
