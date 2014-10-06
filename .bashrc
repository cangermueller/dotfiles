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


export EDITOR="vim"
export SVN_EDITOR=$EDITOR
export VD="$HOME/.vim"
export VRC="$HOME/.vimrc"

alias ll='ls -Al'
alias la='ls -A'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias le='less'

alias mv='mv -i' # prompt before overwriting files

alias vcs="rm -f \.*swp"
alias vi="vim -p"

alias ipn='ipython notebook --no-browser'
alias ipc='ipython console'

alias gits='git status -u'
alias gitc='git commit'
alias gitca='git commit -a'

alias tma='tmux attach'
alias tms='tmux new -s'

alias cx='chmod u+x'
function countd {
  ls $1 | wc -l
}

function knit2pdf {
  rnw=${1:-main.Rnw}
  Rscript -e "library(knitr); knit2pdf('$rnw')"
}

function zipd {
  zip -r $(basename $1).zip $1
}


export PATH="$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
