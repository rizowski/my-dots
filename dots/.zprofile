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

check_to_update() {
  local script=$1
  local app=$2
  local updateDays=${3:-7}
  local settingsDir=~/.dot-settings
  local settingsPath=$settingsDir/$app

  declare -i updateDays

  [ -d "$settingsDir" ] || mkdir $settingsDir
  [ -f "$settingsPath" ] || set_ran_date "$settingsPath"

  declare -i current=$(($(date +%s) / 60 / 60 / 24))
  declare -i days=$(cat $settingsPath)
  declare -i been=$(($current - $days))
  declare -i days
  declare -i been

  if (($been >= $updateDays)); then
    if read -q "?${YELLOW}Do you want to update ${2}? ${CYAN}[y/n]${WHITE} "; then
      sh -c $script
    else
      set_ran_date "$settingsPath"
    fi
  fi
}

check_to_update ~/bin/brew-update brew 7

# FNM CD Hook
eval "$(fnm env --use-on-cd --corepack-enabled --resolve-engines --version-file-strategy recursive)"

autoload -U add-zsh-hook

aws_auto_profile_hook() {
  file=$(upfind .aws-profile)

  [[ -z "$file" ]] && unset AWS_PROFILE && return

  profile=$(cat "$file")

  [[ -z "$profile" ]] && echo ".aws-profile was empty.\nNo profile found $file" && return

  echo "Using AWS profile: $profile"

  export AWS_PROFILE="$profile"
}

add-zsh-hook chpwd aws_auto_profile_hook &&
  aws_auto_profile_hook

fpath=(/usr/local/share/zsh-completions $fpath)

cloc-git() {
  git clone --depth 1 "$1" temp-linecount-repo &&
    printf "('temp-linecount-repo' will be deleted automatically)\n\n\n" &&
    scc temp-linecount-repo &&
    rm -rf temp-linecount-repo
}
