# Layout
export TERM="xterm-256color"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# General
export EDITOR="vim"
export bin="$HOME/bin"
export PATH="$bin:$PATH"
export tmp="$HOME/tmp"
alias tmp="cd $tmp"
export opt="$HOME/opt"
export stow="$HOME/opt/stow"
export PATH="$opt/bin:$PATH"
export sr="$HOME/.ssh"
export src="$sr/config"


# Configs
export etc="$HOME/etc"
export cfg="$HOME/.config"

export zrc="$HOME/.zshrc.global"
alias zrc="source $zrc"
export zrC="$HOME/.zshrc.local"
alias zrC="source $zrC"
export ZRC="$HOME/.zshrc"

# Dotfiles
export Dot="$etc/dotfiles"
export dot="$Dot/dotfiles"
alias dot="$Dot/dotdrop.sh"
alias doti="dot install -p base"

function dotI {
  files=""
  for fpath in $@; do
    if [[ ${fpath:0:1} != "-" ]]; then
      fpath=$(realpath $fpath)
    fi
    files="$files $fpath"
  done
  cmd="dot import -p base $files"
  echo $cmd
  eval $cmd
}

# Cheat sheets
export docs="$HOME/docs"
export cs="$docs/cheat"
export cb="$cs/bash"
export cp="$cs/python"
export cpn="$cp/numpy.txt"
export cpp="$cp/pandas.txt"
export cps="$cp/seaborn.txt"
export cpt="$cp/tensorflow.txt"
export cr="$cs/R"
export cv="$cs/vi"

# Testing
export tests="$HOME/docs/tests"
export testp="$tests/test.py"
export testb="$tests/test.sh"
alias testp="python $testp"

# Alias
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias l.='ls ./'
alias l..='ls ../'
alias l...='ls ../../'
alias l....='ls ../../../'
alias rr='rm -rf'
alias rf='rm -rf'
alias cr='cp -r'
alias cx='chmod u+x'
alias mv='mv -i' # prompt before overwriting files
alias mk='mkdir -p'
alias c='clear'
alias bc='bc -l' # Calculator
alias du='du -h'
alias dus='du -hs'
alias df='df -h'
alias tx='tar xf'
alias tc='tar cf'
alias grep='grep --color'
alias tac='tail -r'
alias le='less -IS'
alias scp='scp -r'
alias Make='make -B'
alias wcl='wc -l'
alias h10='head -n 10'
alias h20='head -n 20'
alias h50='head -n 50'
alias replace='replace.py'

# ls
export CLICOLOR=1
export LSCOLORS="ExFxCxDxBxegedabagacad" # Colors OSX
alias ll='ls -Alh'
alias lld='ls -Alhd'
alias la='ls -A'
alias lns='ln -s'

# Listing directory content
alias dir0="tree -L 1 -shC"
alias dir1="tree -L 2 -shC"
alias dir="tree -L 3 -shC"
alias dirh="dir -a"
alias dir9="tree -L 100 -shC"

# Job management
alias htop='htop -u $USER -d 10'
alias Jobs='jobs -l'
alias Kill='kill -9'
alias pKill="pkill -9 -n"
alias psa='ps a'
alias pss='pgrep -a'
alias psk='pkill -9'

function psx {
  local pattern=${1:-""}
  ps ax | grep "$pattern"
}


# Functions

function abspath {
  # Return absolute path of possible non-existing file.
  file=$1
  if $(hash realpath &> /dev/null); then
    cmd="realpath"
  else
    cmd="readlink -f"
  fi
  if [[ -e $file ]]; then
    fpath=$($cmd $file)
  else
    if [[ ${file:0:1} == '/' ]]; then
      fpath=$file
    else
      fpath="$PWD/$file"
    fi
  fi
  if $(hash pbcopy &> /dev/null); then
    echo $fpath | tr -d '\n' | pbcopy
  fi
  echo $fpath
}
alias abs="abspath"

function grepr {
  local pattern="$1"
  local suffixes="${2:-py}"

  include=""
  for suffix in $suffixes; do
    include="$include --include '*$suffix'"
  done
  cmd="grep --ignore-case $include -R '$pattern' ."
  eval $cmd
}

function grepp {
  grepr "$1" "py"
}

function grepc {
  grepr "$1" "hpp cpp h cc"
}

function cdd {
  cd $(cdd.py $@)
}

function pin {
  local pw=$1
  shift
  for i in $@; do
    echo ${pw:$((i - 1)):1}
  done
}

# Count files
function countf {
  ls $@ | wc -l
}

# Count files recursively
function Countf {
  local pattern="$1"
  local dir="${2:-.}"
  cmd="find $dir -maxdepth 1 -not -path '.'"
  if [[ -n $pattern ]]; then
    cmd="$cmd -name '$pattern'"
  fi
  cmd="$cmd | wc -l"
  eval $cmd
}

# Count columns (csv) file
function countc {
  local file="$1"
  local sep="${2:-,}"
  head -n 1 $file | tr $sep '\n' | wc -l
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


# temporary directories

export tdirs="$tmp/tdirs"

function tdir {
  name=${1:-$RANDOM}
  fpath="$tmp/$(date +%y%m%d_%H%M%S)_tmpdir_$name"
  mkdir -p $fpath
  export tdir=$fpath
  echo $fpath
  echo $fpath >> $tdirs
}

function utdir {
  local idx=${1:-1}

  if [[ -e $tdirs ]]; then
    export tdir=$(tail -n $idx $tdirs | head -n 1)
  fi
}
utdir

alias ltdir="tail $tdirs"

function ctdir {
  eval 'cd $tdir'
}

function rtdirs {
  to_del=$(ls -d $tmp/*_tmpdir* $tdirs 2> /dev/null)
  if [[ -n $to_del ]]; then
    echo $to_del
    rm -rfI $tmp/*_tmpdir* $tdirs
  fi
}


# vim
export VR="$HOME/.vim"
export VRC="$HOME/.vimrc"
export VB="$VR/bundle"
export VV="$VR/vundle.vim"
export VF="$VR/ftplugin"
export VFP="$VF/python.vim"
export VFPL="$VF/python_local.vim"
export VFC="$VF/cpp.vim"
export VLp="$VR/local_pre.vim"
export VLP="$VR/local_post.vim"

alias vim="vim -p"
alias vi="vim -p"
alias vih="vim -o"
alias viv="vim -O"
alias vid="vimdiff"


# tmux
export tmux="$HOME/.tmux"
export trc="$HOME/.tmux.conf"
alias tmux="tmux -u"
alias tml="tmux ls"
alias tmk="tmux kill-session -t"

function tma {
  local name=$1
  if [[ -z $name ]]; then
    cmd="tmux attach || tmux new"
  else
    cmd="tmux attach -t $name || tmux new -s $name"
  fi
  eval $cmd
}

function tmn {
  local name=$1
  cmd="tmux new"
  if [[ -n $name ]]; then
    cmd="$cmd -s $name"
  fi
  eval $cmd
}


# Python


## IPython
export ipy="$HOME/.ipython"
export ipyp="$ipy/profile_default/startup/00_default.py"
alias ipc='ipython'
alias ipn='ipython notebook --no-browser'

## PIP
alias pipi='pip install -U'
alias pipr='pip uninstall'
alias pips='pip search'
alias pipl='pip list'
alias pipo='pip list --outdated'


# Apt
alias apti="sudo apt-get install"
alias aptr="sudo apt-get remove"
alias aptu="sudo apt-get update"
alias aptU="sudo apt-get upgrade"
alias apts="apt-cache search"


# MacPort
alias port='/opt/local/bin/port'
alias porti="port install"
alias portr="port uninstall"
alias portu="port selfupdate"
alias portU="port upgrade outdated"
alias ports="port search"


# Git
export GIT_SSL_NO_VERIFY=true # avoid SSL problem
alias gg="git"
alias ggs='git status -u'
alias ggc='git commit -m'
alias ggca='git add -A :/ && git commit -a -m'
alias ggcc='ggca "Update configs"'
alias ggcd='ggca "Update documentation"'
alias ggcm='ggca "Minor changes"'
alias ggcr='ggca "Update README"'
alias ggcs='ggca "Update cheat sheets"'
alias gga='git add'
alias ggme='git merge'
alias ggmv='git mv'
alias ggrm='git rm'
alias ggms='git merge sync/master'
alias ggA='git add -A :/'
alias ggd='git diff'
alias ggp='git pull'
alias ggP='git push'
alias ggx='git annex'
alias ggb='git branch -a'
alias ggi='git init .'
alias ggco='git checkout'
alias ggcl='git clone'
alias ggl='git log'
alias ggbc='git rev-parse --abbrev-ref HEAD'
alias ggt='git tag'
alias ggT='git tag -l'
alias ggsm='git submodule'

# checkout current branch to directory
function gitcod {
  fpath=$1
  if [ -n "$fpath" ]; then
    git checkout-index -a -f --prefix=$fpath/
  fi
}


# HDF
alias hls='h5ls'
alias hLs='h5ls -r'
alias hd='h5dump -d'


# ripgrep
alias rgi="rg -i"
alias rgp="rg -t py"
alias rgf="rg --files --glob"
alias rgl="rg -F"


# Compression
function zipd {
  local fpath=$1
  fpath=${fpath%/}
  zip -r $(basename $fpath).zip $fpath
}

alias zipr="zip -r"
alias gz="gzip"
alias guz="gunzip"

function ggz {
  infile=$1
  outfile=$2
  if [[ -z $outfile ]]; then
    outfile=$1.gz
  fi
  gzip -c $infile > $outfile
}

function gguz {
  infile=$1
  outfile=$2
  if [[ -z $outfile ]]; then
    outfile=${infile%.gz}
  fi
  gunzip -c $infile > $outfile
}


# FZF / Fuzzy Finder
# c-t // paste selected files into command line
# fh: cmd history
# fkill: kill process
# fe: open with $EDITOR
# fpane, fs: tmux pane / session
# zd: cd to parent directory
export FZF_DEFAULT_OPTS="--multi --extended"
extras="$dot/fzf-extras/fzf-extras.sh"
if [[ -f $extras ]]; then
  source $extras
fi

alias fz="fzf"
alias fp="fzf_preview.sh"
alias fd="zd"
