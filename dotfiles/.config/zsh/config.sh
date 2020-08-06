export cfg="$HOME/.config"
export br="$cfg/bash"

br="$cfg/bash"
sr="$cfg/shell"
zr="$cfg/zsh"

source "$sr/config.sh"
source "$zr/global.sh"
source "$zr/local.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
