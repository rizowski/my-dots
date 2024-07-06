case $(uname) in
Darwin)
  eval "$(/opt/homebrew/bin/brew shellenv)"
  eval "$(rbenv init - zsh)"
  source $HOME/.antigen/antigen.zsh
  export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
  HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  ;;
Linux)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export PATH="$HOMEBREW_PREFIX/.linuxbrew/bin:$PATH"
  export PATH="$HOMEBREW_PREFIX/.linuxbrew/sbin:$PATH"
  source $HOMEBREW_PREFIX/share/antigen/antigen.zsh
  ;;
esac
autoload -U colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval $COLOR='$fg_no_bold[${(L)COLOR}]' #wrap colours between %{ %} to avoid weird gaps in autocomplete
  eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='%{$reset_color%}'

eval "$(zoxide init zsh)"

if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER"
fi

# zmodload zsh/zprof
antigen use oh-my-zsh

antigen bundle docker-compose
antigen bundle git
# antigen bundle changyuheng/fz
# antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle colored-man-pages
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle akoenig/npm-run.plugin.zsh
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle command-not-found
antigen bundle supercrabtree/k
antigen cache-gen

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.profile

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# added by Snowflake SnowSQL installer v1.2
export PATH="$HOMEBREW_PREFIX/opt/openjdk@11/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/ruby@2.7/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
