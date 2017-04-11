# Settings
stty -ixon  # disable <c-s> flow control
shopt -s extglob


# Layout
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export LANG=en_US.utf8

case "$TERM" in
    xterm-*color | xterm | screen)
        PS1='${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\h: \[\e[01;32m\]\w\[\e[00m\] $ '
        ;;
    *)
        PS1='${debian_chroot:+($debian_chroot)}\h: \w $ '
        ;;
esac


# General
export EDITOR="vim"
export SVN_EDITOR=$EDITOR
export SR="$HOME/.ssh"
export SRC="$SR/config"
export BIN="$HOME/bin"
export PATH="$HOME/bin:$PATH"
export TMP="$HOME/tmp"


# Configs
export ETC="$HOME/etc"
export CFG="$ETC/configs"
export BRC="$ETC/configs/.bashrc"
export BRc="$ETC/.bashrc.local"
alias brc="source $HOME/.bashrc"
export TRC="$HOME/.tmux.conf"
export TRc="$HOME/.tmux.conf.local"


# Alias
alias ll='ls -Alh'
alias lL='ls -Alhd'
alias la='ls -A'
alias lD='ls -d'
alias lDl='ls -ld'
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
alias df='df -h'
alias tx='tar xf'
alias tc='tar cf'
alias jobs='jobs -l'
alias Kill='kill -9'
alias grep='grep --color'
alias tac='tail -r'
alias findf='find . -iname '
alias sql='sqlite3 -list'
alias less='less -S'
alias le='less -S'
alias scp='scp -r'
alias Make='make -B'
alias wat='watch -n 1 tail -n 20'
alias wcl='wc -l'

alias dir0="tree -L 1 -shC"
alias dir1="tree -L 2 -shC"
alias dir="tree -L 3 -shC"
alias dir9="tree -L 100 -shC"



# Functions

function grepr {
 pattern=$@
 grep -rI $pattern .
}

function save {
  a=${1%/}
  if [[ $a == *.save ]]; then
    b=${a%.save}
  else
    b="$a.save"
  fi
  mv $a $b
}

function Save {
  a=${1%/}
  if [[ $a == *.save ]]; then
    b=${a%.save}
  else
    b="$a.save"
  fi
  cp -r $a $b
}

function Xargs {
  cmd=$1
  xargs -Ix $cmd x
}

function geti {
  i=$1
  shift
  values=($@)
  echo ${values[$i]}
}

function cdd {
  cmd="find . -maxdepth 1 -not -path '*/\.*' -name"
  files=$($cmd "1*$1" | sort -r)
  if [ -z "$files" ]; then
    files=$($cmd "*$1" | sort -r)
  fi
  for file in $files; do
    if [[ -d $file ]]; then
      cd $file
      break
    fi
  done
}

function cf {
  files=${@:-*}
  cmd="ls -d $files | wc -l"
  eval $cmd
}

function pdf2png {
  files=$@
  for file in $files; do
    cmd="convert -density 300 $file ${file%\.*}.png"
    eval $cmd
  done
}


function ddir {
  name=$(date '+%y%m%d')
  if [[ -n $1 ]]; then
    name="${name}_$1"
  fi
  mkdir $name
}

alias cdate='date +%y%m%d_%H%M%S'

function tdir {
  name=${1:-$RANDOM}
  path="$TMP/$(date +%y%m%d_%H%M%S)_tmpdir_$name"
  mkdir -p $path
  export tmp=$path
  echo $path
}




# vim
export VR="$HOME/.vim"
export VRC="$HOME/.vimrc"
export VS="$VR/spell"
export VV="$VR/vundle.vim"
export VF="$VR/ftplugin"
export VFP="$VF/python.vim"
export VFR="$VF/r.vim"
export VFT="$VF/tex.vim"

alias vcs="rm -f \.*swp"
alias vim="vim --servername VIM -p"
alias vi="vim --servername VIM -p"
alias vid="vimdiff"


# tmux
export TRC="$HOME/.tmux.conf"
alias tma='tmux attach'
alias tmux='tmux -u'


# Python
alias pyt='py.test -v -s'
alias wo='workon -n'
alias won='workon'
alias deact='deactivate'

## IPython
export ipy="$HOME/.ipython"
export ipyp="$ipy/profile_default/startup/00_default.py"

alias ipc='jupyter console'
alias ipn='jupyter notebook --no-browser'
alias ips='jupyter nbconvert --to slides --post serve'

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

## PIP
alias pipi='sudo pip install -U'
alias pipu='sudo pip uninstall'
alias pips='pip search'
alias pipl='pip list'
alias pipL='pip list -o | grep Latest'
alias pipdev="sudo python setup.py develop"

function pipu {
  sudo=${1:-1}
  pip list -o | grep Latest | cut -f 1 -d ' ' | while read name; do
    echo "Updating $name ..."
    cmd="pip install -U $name"
    if [ $sudo -eq 1 ]; then
      cmd="sudo -H $cmd"
    fi
    eval $cmd
    if [ $? -ne 0 ]; then
      echo "$name failed!"
      echo $name >> log.err
    fi
  done
}



# Git
export GIT_SSL_NO_VERIFY=true # avoid SSL problem
alias gits='git status -u'
alias gitc='git commit -m'
alias gitca='git add -A :/ && git commit -a -m'
alias gitcm='git commit -a -m "Minor changes"'
alias gitcd='git commit -a -m "Update documentation"'
alias gitcC='git commit -a -m "Update configs"'
alias gita='git add'
alias gitv='git mv'
alias gitm='git merge'
alias gitms='git merge sync/master'
alias gitA='git add -A :/'
alias gitd='git diff'
alias gitp='git pull'
alias gitP='git push'
alias gitx='git annex'
alias gitb='git branch -a'
alias giti='git init .'
alias gitco='git checkout'
alias gitcl='git clone'
alias gitl='git log'
alias gitbc='git rev-parse --abbrev-ref HEAD'
alias gitt='git tag'
alias gitT='git tag -l'

# checkout current branch to directory
function gitcod {
  path=$1
  if [ -n "$path" ]; then
    git checkout-index -a -f --prefix=$path/
  fi
}


# HDF
alias hls='h5ls'
alias hLs='h5ls -r'
alias hd='h5dump -d'



# R
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


# Compression
function zipd {
  zip -r $(basename $1).zip $1
}

alias zipr="zip -r"
alias gz="gzip"
alias gZ="gunzip"

function Gz {
  infile=$1
  outfile=$2
  if [[ -z $outfile ]]; then
    outfile=$1.gz
  fi
  gzip -c $infile > $outfile
}

function GZ {
  infile=$1
  outfile=$2
  if [[ -z $outfile ]]; then
    outfile=${infile%.gz}
  fi
  gunzip -c $infile > $outfile
}


# Testing
alias tdirc="rm -rf $TMP/1*_tmpdir_*"

export TES="$HOME/research/test"
export TESP="$TES/test.py"
export TESS="$TES/test.sh"
export TESR="$TES/test.Rmd"

alias tesp="python $TESP"
alias tess="$TESS"
