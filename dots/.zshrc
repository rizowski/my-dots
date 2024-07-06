case $(uname) in
Darwin)
  eval "$(rbenv init - zsh)"
  source $HOME/.antigen/antigen.zsh
  HB_CNF_HANDLER="$HOMEBREW_PREFIX/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  # Added by OrbStack: command-line tools and integration
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  ;;
Linux)
  source $HOMEBREW_PREFIX/share/antigen/antigen.zsh
  HB_CNF_HANDLER="$HOMEBREW_PREFIX/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  ;;
esac

if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER"
fi

autoload -U colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval $COLOR='$fg_no_bold[${(L)COLOR}]' #wrap colours between %{ %} to avoid weird gaps in autocomplete
  eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='%{$reset_color%}'

eval "$(zoxide init zsh)"

# zmodload zsh/zprof
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  docker-compose
  git
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  colored-man-pages
  unixorn/autoupdate-antigen.zshplugin
  akoenig/npm-run.plugin.zsh
  zsh-users/zsh-history-substring-search
  command-not-found
  supercrabtree/k
  cache-gen
EOBUNDLES

# antigen bundle changyuheng/fz
# antigen bundle Aloxaf/fzf-tab

case $(uname) in
Darwin)
  # Commands for OS X go here
  antigen bundle macos
  ;;
Linux)
  # Commands for Linux go here
  ;;
esac

# workaround for https://github.com/zsh-users/antigen/issues/675
THEME=robbyrussell
antigen list | grep $THEME
if [ $? -ne 0 ]; then antigen theme $THEME; fi
# antigen theme robbyrussell

antigen apply

eval "$(starship init zsh)"

source ~/.config/op/plugins.sh
source ~/.aliases

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
