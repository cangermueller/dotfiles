#!/usr/bin/env bash

set -e
shopt -s extglob

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

run "cd $etc"
# run "git clone https://github.com/Bash-it/bash-it.git bash_it"
run "cd $etc/bash_it/custom"
run "ln -s ../../configs/dotfiles/bash_it/custom/themes ."

source "$cfg/bash_it/bash_it.sh"
