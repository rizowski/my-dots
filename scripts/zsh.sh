#!/bin/bash
source $PWD/scripts/helpers.sh

[ -d "$HOME/.oh-my-zsh" ] || git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

PLUGINS=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins

install_or_update $PLUGINS https://github.com/zsh-users/zsh-syntax-highlighting
install_or_update $PLUGINS https://github.com/supercrabtree/k
install_or_update $PLUGINS https://github.com/zsh-users/zsh-autosuggestions
install_or_update $PLUGINS https://github.com/lukechilds/zsh-nvm

chsh -s /bin/zsh