# Changing default shell
alias set_bash="chsh -s /bin/bash"
alias set_zsh="chsh -s /usr/bin/zsh"
alias set_fish="chsh -s /opt/local/bin/fish"

function prepend_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

function append_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# General
export EDITOR="vim"
export SVN_EDITOR=$EDITOR
export bin="$HOME/bin"
prepend_path $bin
export tmp="$HOME/tmp"
export opt="$HOME/opt"
export stow="$HOME/opt/stow"
prepend_path "$opt/bin"
export ssr="$HOME/.ssh"
export ssc="$sr/config"
export etc="$HOME/etc"

# Configs
export cfg="$HOME/.config"

## Shell
export sr="$cfg/shell"
export src="$sr/config.sh"

## Bash
export br="$cfg/bash"
export brc="$br/config.sh"
alias brc="source $brc"
export brg="$br/global.sh"
export brl="$br/local.sh"

# ZSH
export zr="$cfg/zsh"
export zrc="$zr/config.sh"
alias zrc="source $zrc"
export zrg="$zr/global.sh"
export zrl="$zr/local.sh"


# Dotfiles
export Dot="$etc/dotfiles"
export dot="$Dot/dotfiles"
alias dot="$Dot/dotdrop.sh"
alias doti="dot install -p base"  # doti f_shell_config.sh

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

## OSX colors
# export LSCOLORS='GxFxCxDxBxegedabagaced'
# export LSCOLORS='ExFxCxDxBxegedabagacad'
# export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx'
export LSCOLORS='ExGxBxDxCxEgEdxbxgxcxd'

## Unix colors
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# alias ls --color=auto
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
alias abs="abspath.py"

function cdd {
  cd $(cdd.py $@)
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
  echo $name
  mkdir $name
}

alias cdate='date +%y%m%d_%H%M%S'

# temporary directories

function tdir {
  name=${1:-$RANDOM}
  tpath="$tmp/$(date +%y%m%d_%H%M%S)_tmpdir_$name"
  mkdir -p $tpath
  export tdir=$tpath
  echo $tpath
}

function ltdir {
 ls -d $tmp/*_*_tmpdir_* 2> /dev/null | sed -E 's/ /\n/g'
}

function utdir {
  tpath=$(ltdir | tail -n 1)
  if [[ -n $tpath ]]; then
    export tdir=$tpath
    echo $tdir
  fi
}
utdir &> /dev/null

function ctdir {
  eval 'cd $tdir'
}

function rtdir {
  rm_confirm.py $(ltdir)
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
  local tpath=$1
  tpath=${tpath%/}
  zip -r $(basename $tpath).zip $tpath
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
