# Exit if the shell is not-interactive
[ "$-" != "${-#*i}" ] || return

export cfg="$HOME/.config"

br="$cfg/bash"
sr="$cfg/shell"

source "$sr/config.sh"
source "$br/global.sh"
source "$br/local.sh"
