#!/usr/bin/env bash


function is_debug {
  local args=$@
  if [[ $args == "t" ]]; then
    echo 1
  else
    echo 0
  fi
}

function log {
  (>&2 echo "$@")
}

check=1
debug=$(is_debug $1)
function run {
  local cmd="$@"
  log
  log "#################################"
  log $cmd
  log "#################################"
  if [[ $debug -ne 1 ]]; then
    eval $cmd
    if [ $check -ne 0 -a $? -ne 0 ]; then
      log "Command failed!"
      exit 1
    fi
  fi
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
  run "git status"
  if [[ $(git status) != *'Changes not staged for commit'* ]]; then
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

header "vim"
update "$dot/.vim"

header "dotfiles"
update $Dot

header "cheat"
update $cs "Update cheat sheats"
