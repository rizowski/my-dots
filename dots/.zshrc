### Zinit bootstrap
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  print -P "%F{33}Installing zinit...%f"
  command mkdir -p "$(dirname "$ZINIT_HOME")" && command chmod g-rwX "$(dirname "$ZINIT_HOME")"
  command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

case $(uname) in
Darwin)
  eval "$(rbenv init - zsh)"
  HB_CNF_HANDLER="$HOMEBREW_PREFIX/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  ;;
Linux)
  HB_CNF_HANDLER="$HOMEBREW_PREFIX/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
  ;;
esac

if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER"
fi

autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -Uz add-zsh-hook

eval "$(zoxide init zsh)"

# OMZ libraries that the plugins/keybindings below depend on.
zinit snippet OMZL::git.zsh
zinit snippet OMZL::key-bindings.zsh

# OMZ plugins
zinit snippet OMZP::git
zinit snippet OMZP::gh
zinit snippet OMZP::sudo
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::command-not-found
zinit snippet OMZP::docker-compose
zinit snippet OMZP::kubectl
zinit snippet OMZP::aws
zinit snippet OMZP::extract

# External plugins. fzf-tab must load before autosuggestions/syntax-highlighting;
# fast-syntax-highlighting must load last.
zinit light akoenig/npm-run.plugin.zsh
zinit light supercrabtree/k
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zdharma-continuum/fast-syntax-highlighting

# Make fast-syntax-highlighting color known commands like zsh-syntax-highlighting does.
FAST_HIGHLIGHT_STYLES[command]=fg=green
FAST_HIGHLIGHT_STYLES[builtin]=fg=green
FAST_HIGHLIGHT_STYLES[function]=fg=green
FAST_HIGHLIGHT_STYLES[alias]=fg=green
FAST_HIGHLIGHT_STYLES[precommand]=fg=green,underline
FAST_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY       # global: all sessions share one history, live
setopt EXTENDED_HISTORY    # record timestamps
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt AUTO_CD             # bare paths like ../../ cd instead of trying to exec

source <(fzf --zsh)
eval "$(atuin init zsh --disable-up-arrow)" # atuin owns ctrl-r; up-arrow stays native zsh
eval "$(starship init zsh)"

# Inline, prefix-filtered history cycling on up/down (no menu, single Enter to run).
# Must come after atuin init so it isn't overridden.
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# source ~/.config/op/plugins.sh
source ~/.aliases

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# proto
export PROTO_HOME="$HOME/.proto";
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH";

# Added by GitButler installer
export PATH="$HOME/.local/bin:$PATH"
eval "$(but completions zsh)"

aws_auto_profile_hook() {
  file=$(upfind .aws-profile)

  [[ -z "$file" ]] && unset AWS_PROFILE && return

  profile=$(cat "$file")

  [[ -z "$profile" ]] && echo -e ".aws-profile was empty.\nNo profile found $file" && return

  if [[ "$AWS_PROFILE" != "$profile" ]]; then
    echo "AWS_PROFILE changing from '${AWS_PROFILE:-unset}' to '$profile'"
  fi

  export AWS_PROFILE="$profile"
}

add-zsh-hook chpwd aws_auto_profile_hook &&
  aws_auto_profile_hook

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
