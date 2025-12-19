# source ~/.op/plugins.sh 2>/dev/null
# https://github.com/keybase/keybase-issues/issues/1712#issuecomment-141226705
export GPG_TTY=$(tty)

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# who cares about casing? I don't
set completion-ignore-case on

set_ran_date() {
  echo $(($(date +%s) / 60 / 60 / 24)) >$1
}

should-update ~/bin/brew-update brew 7

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

fpath=(/usr/local/share/zsh-completions $fpath)

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
export PATH=/opt/whalebrew/bin:$PATH
