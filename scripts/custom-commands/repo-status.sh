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
printf "\033[0;35m✗ Not a repo\033[0m\n"
printf "============== Deets ==============\n"

for f in $dir
do
  [ -d "${f}" ] || continue

  if [ -d "$f/.git" ]
  then
    cd $f

    the_folder="$(basename "$f")"
    the_parent="$(basename "$(dirname "$f")")"
    the_place="$the_parent/$the_folder"
    status="$(git status)"

    if [ $(echo "$status" | grep Untracked -c) -ne 0 ] || [ $(echo "$status" | grep modified -c) -ne 0 ]; then
      printf "\033[0;33m✗ $the_place\033[0m\n"
    elif [ $(echo "$status" | grep 'Your branch is ahead' -c) -ne 0 ]; then
      printf "\033[0;34mᎮ $the_place\033[0m\n"
    else
      printf "\033[0;32m✓ $the_place\033[0m\n"
    fi

    cd ../
  else
    printf "\033[0;35m✗ $the_place\033[0m\n"
  fi
done
