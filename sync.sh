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


alias gits='git status'
alias gitca='git add -A :/ && git commit -a -m'
alias gitcc='gitca "Update configs"'
alias gitcd='gitca "Update documentation"'
alias gitcs='gitca "Update cheat sheets"'
alias gitp='git pull'
alias gitP='git push'


# Configs
run "cd $cfg"
run "gits"
if [[ $(ask) -ne 1 ]]; then
  exit 0
fi
run "gitcc"
run "gitp"
run "gitP"

exit 0


# VIM
run "cd $VR"
run "gitcc"
run "gitp"
run "gitP"


# Cheat sheats
run "cd $cs"
run "gitcd"
run "gitp"
run "gitP"
