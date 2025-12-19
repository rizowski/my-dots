source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

case $(uname) in
Darwin)
  eval "$(rbenv init - zsh)"
  if [ ! -d "$HOME/.antigen" ] || [ ! -f "$HOME/.antigen/antigen.zsh" ]; then
    mkdir -p "$HOME/.antigen"
    curl -L git.io/antigen >"$HOME/.antigen/antigen.zsh"
  fi
  source $HOME/.antigen/antigen.zsh
  HB_CNF_HANDLER="$HOMEBREW_PREFIX/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  # Added by OrbStack: command-line tools and integration
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  ;;
Linux)
  if [ ! -d "$HOMEBREW_PREFIX/.antigen" ] || [ ! -f "$HOMEBREW_PREFIX/.antigen/antigen.zsh" ]; then
    mkdir -p "$HOMEBREW_PREFIX/.antigen"
    curl -L git.io/antigen >"$HOMEBREW_PREFIX/.antigen/antigen.zsh"
  fi
  source $HOMEBREW_PREFIX/share/antigen/antigen.zsh
  HB_CNF_HANDLER="$HOMEBREW_PREFIX/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  ;;
esac

if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER"
fi

autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

eval "$(zoxide init zsh)"

# zmodload zsh/zprof
antigen use oh-my-zsh
# antigen cache-gen # breaks current command autocomplete and validation input

antigen bundles <<EOBUNDLES
  akoenig/npm-run.plugin.zsh
  sudo
  colored-man-pages
  command-not-found
  docker-compose
  git
  supercrabtree/k
  unixorn/autoupdate-antigen.zshplugin
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

case $(uname) in
Darwin)
  # Commands for OS X go here
  antigen bundle macos
  ;;
Linux)
  # Commands for Linux go here
  ;;
esac

setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

# workaround for https://github.com/zsh-users/antigen/issues/675
THEME=robbyrussell
antigen list | grep $THEME
if [ $? -ne 0 ]; then antigen theme $THEME; fi
# antigen theme robbyrussell

antigen apply

source <(fzf --zsh)
eval "$(starship init zsh)"

# source ~/.config/op/plugins.sh
source ~/.aliases

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
