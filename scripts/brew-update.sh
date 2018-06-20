#!/bin/bash

brew=/usr/local/bin/brew

echo "Starting to update brew"
$brew update

echo "Upgrading brews"
$brew upgrade

echo "Upgrading outdated software"
$brew cask upgrade

echo "Cleaning up brews"
$brew cleanup

echo "Cleaning up casks"
$brew cask cleanup

echo "Completed update"
