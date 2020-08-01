set fish_greeting

set -x fi "$HOME/.config/fish"
set -x fif "$fi/functions"
set -x fic "$fi/config.fish"
set -x frc "$fi/global.fish"
alias frc="source $frc"
set -x frC "$fi/local.fish"
alias frC="source $frC"

set -x brc "$HOME/.bashrc.global"
alias brc="source $brc"
set -x brC "$HOME/.bashrc.local"
alias brC="source $brC"

set -x EDITOR "vim"
set -x SVN_EDITOR $EDITOR

set -x tmux "$HOME/.tmux"
set -x trc "$HOME/.tmux.conf"

set -x docs "$HOME/docs"
set -x cs "$docs/cheat"
set -x cb "$cs/bash"
set -x cv "$cs/vi"
set -x cp "$cs/python"
set -x cpn "$cp/numpy.txt"
set -x cpp "$cp/pandas.txt"
set -x cps "$cp/seaborn.txt"

set -x tmp "$HOME/tmp"
set -x VR "$HOME/.vim"
set -x VRC "$HOME/.vimrc"

# Dotfiles
set -x etc "$HOME/etc"
set -x Dot "$etc/dotfiles"
set -x dot "$Dot/dotfiles"
alias dot "$Dot/dotdrop.sh"
alias doti "dot install -p base"


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

# vim
set -x VR "$HOME/.vim"
set -x VRC "$HOME/.vimrc"
set -x VB "$VR/bundle"
set -x VV "$VR/vundle.vim"
set -x VF "$VR/ftplugin"
set -x VFP "$VF/python.vim"
set -x VFPL "$VF/python_local.vim"
set -x VFC "$VF/cpp.vim"
set -x VLp "$VR/local_pre.vim"
set -x VLP "$VR/local_post.vim"

alias vim="vim -p"
alias vi="vim -p"
alias vih="vim -o"
alias viv="vim -O"
alias vid="vimdiff"

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

# FZF / Fuzzy Finder
# c-t // paste selected files into command line
# fh: cmd history
# fkill: kill process
# fe: open with $EDITOR
# fpane, fs: tmux pane / session
# zd: cd to parent directory
set -x FZF_DEFAULT_OPTS "--multi --extended"

# extras="$dot/fzf-extras/fzf-extras.sh"
# if [[ -f $extras ]]; then
#   source $extras
# fi

alias fz="fzf"
alias fp="fzf_preview.sh"
alias fd="zd"
