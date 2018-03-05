#!/bin/bash

brew=/usr/local/bin/brew
logger=/usr/bin/logger

$logger -t brewup "Starting to update brew"
$brew update 2>&1  | $logger -t brewup.update

$logger -t brewup "Upgrading brews"
$brew upgrade 2>&1 | $logger -t brewup.upgrade

$logger -t brewup "Upgrading outdated software"
$brew cask upgrade 2>&1 | $logger -t brew.upgrade

$logger -t brewup "Cleaning up brews"
$brew cleanup 2>&1 | $logger -t brewup.cleanup

$logger -t brewup "Cleaning up casks"
$brew cask cleanup 2>&1 | $logger -t brewup.cleanup

$logger -t brewup "Completed update"
