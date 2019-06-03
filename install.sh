#!/bin/bash
source $PWD/scripts/helpers.sh

echo "Installing personal files"
sh $PWD/scripts/personal-settings.sh
clear

echo "Installing brew"
sh $PWD/scripts/brew.sh
clear

echo "Installing zsh"
sh $PWD/scripts/zsh.sh
clear

echo "installing mac settings"
sh $PWD/scripts/mac-settings.sh
clear

echo "Setting up npm"
sh $PWD/scripts/npm.sh
clear

echo "Setting up yarn"
sh $PWD/scripts/yarn.sh
clear

echo "If this is the first time running. You need to restart the terminal for some changes to take effect."
