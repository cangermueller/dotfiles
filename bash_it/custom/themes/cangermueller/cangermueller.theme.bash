theme="atomic"
# theme="candy"

if [[ "$is_local_host" -eq 1 ]]; then
  host_color="\e[1;49;36m"
else
  host_color="\e[1;49;32m"
fi


source "$BASH_IT/themes/$theme/$theme.theme.bash"

___atomic_prompt_user_info() {
  color=$white
  box="${normal}${LineA}\$([[ \$? != 0 ]] && echo \"${BIWhite}[${IRed}${SX}${BIWhite}]${normal}${Line}\")${Line}${BIWhite}[|${BIWhite}]${normal}${Line}"
  info="${host_color}\u"

  printf "%s|%s|%s|%s" "${color}" "${info}" "${white}" "${box}"
}
