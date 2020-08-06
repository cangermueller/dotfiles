# Remote access
alias gs="glogin && gcert"
alias gj="ssh g2"

# gmount
gmount_src="/google/src/cloud/$USER"
alias gmount="gmount.sh"
alias gumount="gumount.sh"
alias gmount_src="gmount $gmount_src"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/christofa/python/conda/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/christofa/python/conda/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/christofa/python/conda/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/christofa/python/conda/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LSCOLORS='gxfxcxdxbxGxDxabagacad'
export LSCOLORS='exfxcxdxbxGxDxabagacad'
