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

alias gitca='git add -A :/ && git commit -a -m'
alias gitcc='gitca "Update configs"'
alias gitcd='gitca "Update documentation"'
alias gitcs='gitca "Update cheat sheets"'


run "cd $cfg"
run "gitcc"
run "gitp"
run "gitP"

run "cd $VR"
run "gitcc"
run "gitp"
run "gitP"

run "cd $cs"
run "gitcd"
run "gitp"
run "gitP"
