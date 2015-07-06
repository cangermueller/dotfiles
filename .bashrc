stty -ixon  # disable <c-s> flow control
shopt -s extglob

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

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
export SRC="$HOME/.ssh/config"

export GIT_SSL_NO_VERIFY=true # avoid SSL problem

alias ll='ls -Alh'
alias la='ls -A'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias rr='rm -r'
alias rf='rm -rf'
alias cr='cp -r'
alias cx='chmod u+x'
alias mv='mv -i' # prompt before overwriting files
alias du='du -h'
alias grep='grep --color'
alias tree='tree -L 3'
alias less='less -S' # no line wrap
alias findf='find . -name '

alias vcs="rm -f \.*swp"
alias vi="vim --servername VIM -p"
alias vim="vim --servername VIM -p"
alias vid="vimdiff"

alias ipn='ipython notebook --no-browser'
alias ipc='ipython console'
alias ips='ipython nbconvert --to slides --post serve'
alias iph='ipython nbconvert --to html'
alias ipH='ipython nbconvert --to html --ExecutePreprocessor.enabled=True'
alias pyt='py.test -v -s'
alias pudb='pudb3'

alias gits='git status -u'
alias gitc='git commit -m'
alias gitca='git commit -a -m'
alias gitd='git diff'
alias gitp='git pull'
alias gitP='git push'
alias gita='git add'
alias gitA='git add -A'
alias gitx='git annex'
alias gitb='git branch -a'
alias giti='git init .'
alias gitco='git checkout'

alias makeb='make -B'
alias tma='tmux attach'
alias open_ports='sudo netstat -tulpn'

alias wo='workon -n'
alias won='workon'

function cdd {
  if [ -z "$1" ]; then
    dir=$(ls | tail -n 1)
  else
    dir=$(ls | grep $1$ | tail -n 1)
  fi
  if [ -n "$dir" ]; then
    cd $dir
  fi
}
function cds {
  d=$(ls -d *$1 | tail -n 1)
  cd $d
}

function knit2pdf {
  rnw=${1:-main.Rnw}
  Rscript -e "library(knitr); knit2pdf('$rnw')"
}

function rmd2x {
  file=${1:-main.Rmd}
  out=${2:-html}  # html, pdf, word
  Rscript -e "library(rmarkdown); render('$file', output_format='${out}_document')"
}

function rmdRun {
  file=${1:-main.Rmd}
  shift
  args=$@
  if [ ! -z "$args" ]; then
    args=", $args"
  fi
  Rscript -e "library(methods); rmarkdown::run('$file'$args)"
}

function shinyRun {
  file=${1:-main.Rmd}
  shift
  args=${@:-launch.browser = T}
  if [ ! -z "$args" ]; then
    args=", $args"
  fi
  Rscript -e "library(methods); shiny::runApp('$file'$args)"
}

function cf {
  ls ${1:-.} | wc -l
}

function zipd {
  zip -r $(basename $1).zip $1
}


export PATH="$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
