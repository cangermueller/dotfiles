#!/usr/bin/env bash

# args="$@"
args=("$@")
cur=`dirname $(realpath $0)`
opwd=`pwd`

cd $cur
git submodule update --init --recursive
PYTHONPATH=dotdrop python3 -m dotdrop.dotdrop "${args[@]}"
cd ${opwd}
