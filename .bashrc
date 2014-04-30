stty -ixon  # disable <c-s> flow control
shopt -s extglob

case "$TERM" in
    xterm-*color | xterm | screen)
        PS1='${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\h: \[\e[01;32m\]\w\[\e[00m\] $ '
        ;;
    *)
        PS1='${debian_chroot:+($debian_chroot)}\h: \w $ '
        ;;
esac


#export EDITOR="vim"
#export SVN_EDITOR=$EDITOR
export VID="$HOME/.vim"
export VIC="$HOME/.vimrc"

alias ll='ls -Al'
alias la='ls -A'
alias vcs="rm -f \.*swp"
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
#alias vi='vim'
alias ipn='ipython notebook --no-browser'
alias ipc='ipython console --existing'

export PATH="$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
