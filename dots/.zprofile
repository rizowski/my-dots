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

should_update ~/bin/brew-update brew 7

# FNM CD Hook
eval "$(fnm env --use-on-cd --corepack-enabled --resolve-engines --version-file-strategy recursive)"

autoload -U add-zsh-hook

aws_auto_profile_hook() {
  file=$(upfind .aws-profile)

  [[ -z "$file" ]] && unset AWS_PROFILE && return

  profile=$(cat "$file")

  [[ -z "$profile" ]] && echo ".aws-profile was empty.\nNo profile found $file" && return

  export AWS_PROFILE="$profile"
}

add-zsh-hook chpwd aws_auto_profile_hook &&
  aws_auto_profile_hook

fpath=(/usr/local/share/zsh-completions $fpath)
