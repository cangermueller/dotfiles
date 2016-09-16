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
export BIN="$HOME/bin"
export TMP="$HOME/tmp"

# VIM
export Vr="$HOME/.vim"
export Vc="$HOME/.vimrc"
export Vf="$VD/ftplugin"
export Vs="$VD/spell"
export Vp="$Vr/python.vim"
export VR="$Vr/r.vim"
export Vv="$Vr/vundle.vim"

export GIT_SSL_NO_VERIFY=true # avoid SSL problem
alias ll='ls -Alh'
alias la='ls -A'
alias lD='ls -ld'
alias lN='ln -s'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias l.='ls ./'
alias l..='ls ../'
alias l...='ls ../../'
alias l....='ls ../../../'
alias rr='rm -r'
alias rf='rm -rf'
alias cr='cp -r'
alias cx='chmod u+x'
alias mv='mv -i' # prompt before overwriting files
alias du='du -h'
alias jobs='jobs -l'
alias Kill='kill -9'
alias grep='grep --color'
alias tx='tar xf'
alias tc='tar cf'

function grepR {
 pattern=$1
 grep -rI $pattern .
}

alias tac='tail -r'
alias tree='tree -L 3 -sh'
alias findf='find . -iname '
alias txf='tar -xf'
alias tcf='tar -cf'
alias sql='sqlite3 -list'

function save {
  f=${1%/}
  mv $f $f.save
}

function Save {
  f=${1%/}
  cp -r $f $f.save
}

alias vcs="rm -f \.*swp"
alias vim="vim --servername VIM -p"
alias vi="vim"
alias vid="vimdiff"

alias ipc='jupyter console'
alias ipn='jupyter notebook --no-browser'
alias ips='jupyter nbconvert --to slides --post serve'

# call iph file 1 to execute notebook
function iph {
  in=$1
  out=${in%.ipynb}.html
  run=$2
  cmd="jupyter nbconvert --to html --output $out"
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
alias gitl='git log'
alias gitbc='git rev-parse --abbrev-ref HEAD'
alias gitm='git merge sync/master'
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
alias deact='deactivate'

alias wat='watch -n 1 tail -n 20'
alias hls='h5ls'
alias hLs='h5ls -r'
alias hd='h5dump -d'

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
  rnw=${1:-index.Rnw}
  Rscript -e "library(knitr); knit2pdf('$rnw')"
}

function knit2html {
  rnw=${1:-index.Rmd}
  Rscript -e "library(knitr); knit2html('$rnw')"
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

function Mkdir {
  name=$(date '+%y%m%d')
  if [[ -n $1 ]]; then
    name="${name}_$1"
  fi
  mkdir $name
}


alias cdate='date +%y%m%d_%H%M%S'

function Tdir {
  name=${1:-$RANDOM}
  path="$HOME/temp/$(date +%y%m%d_%H%M%S)_tmpdir_$name"
  mkdir -p $path
  export tmp=$path
  echo $path
}

alias Tdirc="rm -rf $HOME/temp/1*_tmpdir_*"

export PATH="$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
