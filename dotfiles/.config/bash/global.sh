# Settings
stty -ixon  # disable <c-s> flow control
shopt -s extglob

# Using aliases with sudo
alias sudo='sudo '

# Layout
export TERM="xterm-256color"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [[ $TERM == xterm* || $TERM == "screen" ]]; then
  export PS1='${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\h: \[\e[01;32m\]\w\[\e[00m\] $ '
else
  export PS='${debian_chroot:+($debian_chroot)}\h: \w $ '
fi

# History
shopt -s cmdhist
shopt -s histappend
export HISTFILESIZE=1000000000
export HISTSIZE=1000000
export HISTTIMEFORMAT="[%y%m%d %H%M%S] "

# Bash-it
if [[ $HOSTNAME =~ (mac) ]]; then
  export is_local_host=1
else
  export is_local_host=0
fi

lscolors=$LSCOLORS
ls_colors=$LS_COLORS
bash_it="$HOME/etc/dotfiles/dotfiles/bash_it"
if [[ -f "$bash_it/bash_it.sh" ]]; then
  source "$bash_it/bash_it.sh"
fi
export LSCOLORS=$lscolors  # overwrite bashit LSCOLORS
export LS_COLORS=$ls_colors  # overwrite bashit LS_COLORS

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
