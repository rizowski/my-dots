#!/bin/bash
source $PWD/scripts/helpers.sh

echo "installing personal files"
sh $PWD/scripts/personal-settings.sh

echo "installing brew"
sh $PWD/scripts/brew.sh

echo "installing zsh"
sh $PWD/scripts/zsh.sh

# echo "installing mac settings"
# sh $PWD/scripts/mac-settings.sh

echo "installing nvm"
sh $PWD/scripts/nvm.sh

echo "setting up npm"
sh $PWD/scripts/npm.sh
