#!/bin/bash

dir="$1"

if [ -z "$dir" ]
then
  dir="`pwd`"
fi

if [[ $dir != */ ]]
then
  dir="$dir/*"
else
  dir="$dir*"
fi

printf "============== Deets ==============\n"
printf "\033[0;33m✗ Contains modified files\033[0m\n"
printf "\033[0;34mᎮ Unpublished commits\033[0m\n"
printf "\033[0;32m✓ Good to go\033[0m\n"
printf "\033[0;36m↓ Repo Behind\033[0m\n"
printf "\033[0;35m✗ Not a repo\033[0m\n"
printf "============== Deets ==============\n"

# has_changes(){
#   [$(git rev-list --right-only --count @{u}...HEAD 2>/dev/null) -ne "0"] || ["$(git rev-list --right-only --count @{u}...HEAD 2>/dev/null)" -ne "0"]
# }


for f in $dir
do
  [ -d "${f}" ] || continue

  echo "Evaluating $f"

  the_folder="$(basename "$f")"
  the_parent="$(basename "$(dirname "$f")")"
  the_place="$the_parent/$the_folder"
  if [ -d "$f/.git" ]
  then
    cd $f

    status="$(git status)"
    icons=""

    echo "$f"

    if [ $(echo "$status" | grep Untracked -c) -ne 0 ] || [ $(echo "$status" | grep modified -c) -ne 0 ]; then
      icons+="\033[0;33m✗\033[0m"
    fi

    if [ $(git rev-list --right-only --count origin/master..HEAD) != "0" ] || [ $(git rev-list --right-only --count @{u}..HEAD) != "0" ]; then
      icons+="\033[0;34mᎮ\033[0m"
    fi

    if [ $(git rev-list --left-only --count origin/master..HEAD) != "0" ] || [ $(git rev-list --left-only --count @{u}..HEAD) != "0" ]; then
      icons+="\033[0;36m↓\033[0m"
    fi

    if [ -z "$icons" ]; then
      icons+="\033[0;32m✓\033[0m"
    fi

    printf "$icons $the_place ($f)\n"

    cd ../
  else
  echo "hit"
    printf "\033[0;35m✗ $the_place\033[0m\n"
  fi
done
