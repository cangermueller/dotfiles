#!/usr/bin/env bash


function run {
  local cmd=$@
  eval $cmd
}


function ask {
  local msg=${1:-"Proceed? [y/n] "}

  while read -es -n 1 -p "$msg"; do
    if [[ $REPLY == 'y' ]]; then
      echo 1
      return
    elif [[ $REPLY == 'n' ]]; then
      echo 0
      return
    fi
  done
}


function update {
  local path=$1
  local msg=${2:-"Update configs"}

  run "cd $path"
  git status
  if [[ $(git status) != *'Changes not staged for commit'* ]]; then
    echo "ignore"
    run "git pull"
    return
  fi
  if [[ $(ask) -ne 1 ]]; then
    exit 0
  fi
  run "git add -A :/ && git commit -a -m '$msg'"
  run "git pull"
  run "git push"
}


function header {
  local msg=$1
  echo "---------------"
  echo $msg
  echo "---------------"
}


header "dotfiles"
update $Dot

header "cheat"
update $cs "Update cheat sheats"
