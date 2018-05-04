#!/usr/bin/env bash

set -e
shopt -s expand_aliases


check=1
function run {

  local cmd=$@
  echo
  echo "#################################"
  echo $cmd
  echo "#################################"
  eval $cmd
  if [ $check -ne 0 -a $? -ne 0 ]; then
    1>&2 echo "Command failed!"
    exit 1
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
  if [[ $(ask) -ne 1 ]]; then
    exit 0
  fi
  run "git add -A :/ && git commit -a -m '$msg'"
  run "git pull"
  run "git push"
}


update $cfg
update $VR
update $cs "Update cheat sheats"
