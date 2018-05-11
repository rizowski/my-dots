#!/bin/bash
source $PWD/scripts/helpers.sh

PLUGINS=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins

if ! command_exists zsh ; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
print "ZSH Installed"

install_or_update $PLUGINS https://github.com/zsh-users/zsh-syntax-highlighting
install_or_update $PLUGINS https://github.com/supercrabtree/k
install_or_update $PLUGINS https://github.com/zsh-users/zsh-autosuggestions
install_or_update $PLUGINS https://github.com/lukechilds/zsh-nvm
