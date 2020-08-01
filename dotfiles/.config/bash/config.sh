export cfg="$HOME/.config"

export br="$cfg/bash"
export brc="$br/config.sh"
export brg="$br/global.sh"
export brl="$br/local.sh"
alias brc="source $brc"

source "$brg"
source "$brl"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
