#!/bin/bash

brew=/usr/local/bin/brew

echo "Starting to update brew"
$brew update

echo "Upgrading outdated software"
$brew upgrade # --greedy

echo "Cleaning up casks and brews"
$brew cleanup

echo "Completed update"
