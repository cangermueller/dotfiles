export cfg="$HOME/.config"
export br="$cfg/bash"
export zr="$cfg/zsh"

source "$br/shared.sh"
source "$zr/global.sh"
source "$br/local.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
