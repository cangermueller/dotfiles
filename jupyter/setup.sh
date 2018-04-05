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

cfg_dir="~/etc/configs/jupyter"

profile_dir="~/.ipython/profile_default/startup"
run "mkdir -p $profile_dir"
run "cd $profile_dir"
run "ln -fs $cfg_dir/profile.py 00_default.py"

jupyter_dir="~/.jupyter"
run "mkdir -p $jupyter_dir"
run "cd $jupyter_dir"
run "ln -fs $cfg_dir/jupyter_notebook_config.py ."

run "cd $cfg_dir"
