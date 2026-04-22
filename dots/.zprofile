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

autoload -U add-zsh-hook

fpath=(/usr/local/share/zsh-completions $fpath)

case $(uname) in
Darwin)
  export PATH=/opt/whalebrew/bin:$PATH
  ;;
esac

[ -f "$HOME/.zprofile.local" ] && source "$HOME/.zprofile.local"


# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
