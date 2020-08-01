set -x LSCOLORS "ExFxCxDxBxegedabagacad"
#
# Remote access
alias gs="glogin && gcert"
alias gj="ssh g2"

set gmount_src "/google/src/cloud/$USER"
alias gmount="gmount.sh"
alias gumount="gumount.sh"
alias gmount_src="gmount $gmount_src"

# MACPORT
set -xg PATH "/opt/local/bin /opt/local/sbin" $PATH
alias port="/opt/local/bin/port"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/christofa/python/conda/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
