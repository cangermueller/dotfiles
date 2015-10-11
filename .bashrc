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
export SRC="$HOME/.ssh/config"

# VIM
export VRC="$HOME/.vimrc"
export VD="$HOME/.vim"
export VF="$VD/ftplugin"
export VS="$VD/spell"

export GIT_SSL_NO_VERIFY=true # avoid SSL problem
alias ll='ls -Alh'
alias la='ls -A'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias l.='ls ../'
alias l..='ls ../../'
alias l...='ls ../../../'
alias rr='rm -r'
alias rf='rm -rf'
alias cr='cp -r'
alias cx='chmod u+x'
alias mv='mv -i' # prompt before overwriting files
alias du='du -h'
alias grep='grep --color'
alias tac='tail -r'
alias tree='tree -L 3'
alias findf='find . -name '
alias txf='tar -xf'
alias tcf='tar -cf'
function save {
  f=${1%/}
  mv $f $f.save
}

alias vcs="rm -f \.*swp"
alias vi="vim -p"
alias vim="vim -p"
alias vid="vimdiff"

alias ipn='ipython notebook --no-browser'
alias ipc='ipython console'
alias ips='ipython nbconvert --to slides --post serve'

# call iph file 1 to execute notebook
function iph {
  in=$1
  out=${in%.ipynb}.html
  run=$2
  cmd="ipython nbconvert --to html --output $out"
  if [ -n "$run" ]; then
    cmd="$cmd --ExecutePreprocessor.enabled=True"
  fi
  $cmd $in
}

alias ipha='for f in $(find . -not -path "./\.*" -name "*ipynb"); do iph $f; done'

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
alias gitbc='git rev-parse --abbrev-ref HEAD'
# checkout current branch to directory
function gitcod {
  path=$1
  if [ -n "$path" ]; then
    git checkout-index -a -f --prefix=$path/
  fi
}

alias Make='make -B'
alias tma='tmux attach'
alias open_ports='sudo netstat -tulpn'

alias wo='workon -n'
alias won='workon'

alias wat='watch -n 1 tail -n 20'

function cdd {
  files=$(find . -maxdepth 1 -name "*$1" | sort -r)
  for file in $files; do
    if [[ -d $file ]]; then
      cd $file
      break
    fi
  done
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

function mzip {
  infile=$1
  outfile=$2
  if [[ -z $outfile ]]; then
    outfile=$1.gz
  fi
  gzip -c $infile > $outfile
}

function Mzip {
  infile=$1
  outfile=$2
  if [[ -z $outfile ]]; then
    outfile=${infile%.gz}
  fi
  gunzip -c $infile > $outfile
}


export PATH="$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
