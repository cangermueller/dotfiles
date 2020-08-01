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

# Changing default shell
alias set_bash="chsh -s /bin/bash"
alias set_fish="chsh -s /opt/local/bin/fish"


# History
shopt -s cmdhist
shopt -s histappend
export HISTFILESIZE=1000000000
export HISTSIZE=1000000
export HISTTIMEFORMAT="[%y%m%d %H%M%S] "


# General
export EDITOR="vim"
export SVN_EDITOR=$EDITOR
export bin="$HOME/bin"
export PATH="$bin:$PATH"
export tmp="$HOME/tmp"
export opt="$HOME/opt"
export stow="$HOME/opt/stow"
export PATH="$opt/bin:$PATH"
export sr="$HOME/.ssh"
export src="$sr/config"
export etc="$HOME/etc"


# Dotfiles
export Dot="$etc/dotfiles"
export dot="$Dot/dotfiles"
alias dot="$Dot/dotdrop.sh"
alias doti="dot install -p base"

function dotI {
  files=""
  for path in $@; do
    if [[ ${path:0:1} != "-" ]]; then
      path=$(realpath $path)
    fi
    files="$files $path"
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
alias sql='sqlite3 -list'
alias le='less -IS'
alias scp='scp -r'
alias Make='make -B'
alias wat='watch -n 1 tail -n 20'
alias wcl='wc -l'
alias h10='head -n 10'
alias h20='head -n 20'
alias h50='head -n 50'

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
    path=$($cmd $file)
  else
    if [[ ${file:0:1} == '/' ]]; then
      path=$file
    else
      path="$PWD/$file"
    fi
  fi
  if $(hash pbcopy &> /dev/null); then
    echo $path | tr -d '\n' | pbcopy
  fi
  echo $path
}
alias abs="abspath"

function cdd {
  cmd="find . -maxdepth 1 -not -path '*/\.*' -name"
  files=$($cmd "1*$1" | sort -r)
  if [ -z "$files" ]; then
    files=$($cmd "*$1*" | sort -r)
  fi
  for file in $files; do
    if [[ -d $file ]]; then
      cd $file
      break
    fi
  done
}

# Count files
function countf {
  ls $@ | wc -l
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
  path="$tmp/$(date +%y%m%d_%H%M%S)_tmpdir_$name"
  mkdir -p $path
  export tdir=$path
  echo $path
  echo $path >> $tdirs
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
  to_del=$(ls -d $tmp/1*_tmpdir_* $tdirs 2> /dev/null)
  if [[ -n $to_del ]]; then
    echo $to_del
    rm -rI $to_del
  fi
}


# vim
export VR="$HOME/.vim"
export VRC="$HOME/.vimrc"
export VB="$VR/bundle"
export VS="$VR/spell"
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
alias ggmv='git mv'
alias ggrm='git rm'
alias ggA='git add -A :/'
alias ggd='git diff'
alias ggp='git pull'
alias ggP='git push'
alias ggb='git branch -a'
alias ggi='git init .'
alias ggco='git checkout'
alias ggcl='git clone'
alias ggl='git log'
alias ggt='git tag'
alias ggT='git tag -l'
alias ggsm='git submodule'

# HDF
alias hls='h5ls'
alias hLs='h5ls -r'
alias hd='h5dump -d'


# ripgrap
alias rgp="rg -t py"
alias rgf="rg --files --glob"


# Compression
function zipd {
  local path=$1
  path=${path%/}
  zip -r $(basename $path).zip $path
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


# Testing
export tests="$HOME/docs/tests"
export tesp="$tests/test.py"
export tess="$tests/test.sh"
alias tesp="python $tesp"


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
alias fl='le $(fz)'


# Bash-it
if [[ $HOSTNAME =~ (mac) ]]; then
  export is_local_host=1
else
  export is_local_host=0
fi

bash_it="$dot/bash_it"
if [[ -f "$bash_it/bash_it.sh" ]]; then
  source "$bash_it/bash_it.sh"
fi
