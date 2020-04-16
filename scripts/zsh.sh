#!/bin/bash
source $PWD/scripts/helpers.sh

PLUGINS=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins
THEMES=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes

install_or_update $PLUGINS https://github.com/zsh-users/zsh-syntax-highlighting
install_or_update $PLUGINS https://github.com/supercrabtree/k
install_or_update $PLUGINS https://github.com/zsh-users/zsh-autosuggestions

#install_or_update $THEMES https://github.com/denysdovhan/spaceship-prompt

#ln -s "$THEMES/spaceship-prompt/spaceship.zsh-theme" "$THEMES/spaceship.zsh-theme"

chsh -s /bin/zsh
