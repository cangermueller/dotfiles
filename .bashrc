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
export SRC="$HOME/.ssh/config"

export GIT_SSL_NO_VERIFY=true # avoid SSL problem


alias ll='ls -Alh'
alias la='ls -A'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias le='less'

alias mv='mv -i' # prompt before overwriting files
alias du='du -h'
alias grep='grep --color'

alias vcs="rm -f \.*swp"
alias vi="vim --servername VIM -p"

alias ipn='ipython notebook --no-browser'
alias ipc='ipython console'
alias ips='ipython nbconvert --to slides --post serve'

alias gits='git status -u'
alias gitc='git commit'
alias gita='git annex'

alias tma='tmux attach'
alias cx='chmod u+x'
alias pyt='py.test-3.4 -vs'

function countd {
  ls $1 | wc -l
}

function knit2pdf {
  rnw=${1:-main.Rnw}
  Rscript -e "library(knitr); knit2pdf('$rnw')"
}

function runApp {
  file=${1:-main.Rmd}
  shift
  args=${@:-launch.browser = T}
  if [ ! -z "$args" ]; then
    args=", $args"
  fi
  Rscript -e "library(methods); shiny::runApp('$file'$args)"
}

function runRmd {
  file=${1:-main.Rmd}
  shift
  args=$@
  if [ ! -z "$args" ]; then
    args=", $args"
  fi
  Rscript -e "library(methods); rmarkdown::run('$file'$args)"
}

function zipd {
  zip -r $(basename $1).zip $1
}

function ve {
  dir=${1:-.venv}
  source $dir/bin/activate
}


export PATH="$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
