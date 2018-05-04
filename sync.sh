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
    # exit 1
  fi
}


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
