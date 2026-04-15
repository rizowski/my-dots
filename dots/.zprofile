# source ~/.op/plugins.sh 2>/dev/null
# https://github.com/keybase/keybase-issues/issues/1712#issuecomment-141226705
export GPG_TTY=$(tty)

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# who cares about casing? I don't
set completion-ignore-case on

[ -s "$HOME/.cache/dot-brew/summary.txt" ] && cat "$HOME/.cache/dot-brew/summary.txt"

NODE_VERSION=20

eval "$(fnm env --use-on-cd --corepack-enabled --resolve-engines --version-file-strategy recursive)" 2 &>/dev/null
if [ -z "$(fnm list | grep -v system)" ]; then
  fnm install $NODE_VERSION && fnm default $NODE_VERSION
else
  if [ -z "$(fnm current)" ]; then
    fnm default $NODE_VERSION
  fi
fi

autoload -U add-zsh-hook

fpath=(/usr/local/share/zsh-completions $fpath)

case $(uname) in
Darwin)
  export PATH=/opt/whalebrew/bin:$PATH
  ;;
esac

[ -f "$HOME/.zprofile.local" ] && source "$HOME/.zprofile.local"

