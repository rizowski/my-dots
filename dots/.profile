# https://github.com/keybase/keybase-issues/issues/1712#issuecomment-141226705
export GPG_TTY=$(tty)

# who cares about casing? I don't
set completion-ignore-case on

# terragrunt --install-autocomplete

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

swap_npm_user() {
  local thedir="$(PWD)"

  if [[ $thedir == *"vs"* ]]; then
    ln -sf ~/git/vs/.npmrc ~/.npmrc
  else
    ln -sf ~/git/personal/.npmrc ~/.npmrc
  fi
}

add-zsh-hook chpwd swap_npm_user && swap_npm_user

check_to_update ~/bin/brew-update brew 7

source ~/.work-profile

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# FNM CD Hook
eval "$(fnm env --use-on-cd)"
export FNM_VERSION_FILE_STRATEGY=recursive

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

cloc-git() {
  git clone --depth 1 "$1" temp-linecount-repo &&
    printf "('temp-linecount-repo' will be deleted automatically)\n\n\n" &&
    scc temp-linecount-repo &&
    rm -rf temp-linecount-repo
}

# kill process on port lol
kpop() {
  sudo lsof -i -P | grep "$1 (LISTEN)"
  echo "What is the pid you would like to kill?"
  read "pid?PID: "

  echo "Killing $pid"

  sudo kill -9 $pid
}
