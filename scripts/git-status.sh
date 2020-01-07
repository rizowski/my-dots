#!/bin/bash

dir="$1"

# No directory has been provided, use current
if [ -z "$dir" ]
then
    dir="`pwd`"
fi

# Make sure directory ends with "/"
if [[ $dir != */ ]]
then
  dir="$dir/*"
else
  dir="$dir*"
fi

# Loop all sub-directories
for f in $dir
do
  # Only interested in directories
  [ -d "${f}" ] || continue

  path="\033[0;35m${f}\033[0m"

  echo "$path"

  # Check if directory is a git repository
  if [ -d "$f/.git" ]
  then
    mod=0
    cd $f

    # Check for modified files
    if [ $(git status | grep modified -c) -ne 0 ]
    then
      mod=1
      echo "Modified files"
    fi

    # Check for untracked files
    if [ $(git status | grep Untracked -c) -ne 0 ]
    then
      mod=1
      echo "Untracked files"
    fi

    # Check for unpushed changes
    if [ $(git status | grep 'Your branch is ahead' -c) -ne 0 ]
    then
        mod=1
        echo "Unpushed commit"
    fi

    # Check if everything is peachy keen
    if [ $mod -eq 0 ]
    then
      echo "Nothing to commit"
    fi

    cd ../
  else
    echo "Not a git repository"
  fi

  echo "---------"
done
