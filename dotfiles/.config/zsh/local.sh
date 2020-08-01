# Local bash configs
export gexp="/google/src/cloud/christofa/sync/google3/experimental/users/christofa"
export ghome="$gexp/home"
export ggoo="$gexp/google"
export grc="$ghome/setup.sh"
alias grc="source $grc"
if ! ls $gexp &> /dev/null; then
  prodaccess
fi
source $grc

# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/usr/local/google/home/christofa/opt/stow/anaconda3/bin/conda' shell.zsh hook 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/usr/local/google/home/christofa/opt/stow/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/google/home/christofa/opt/stow/anaconda3/etc/profile.d/conda.sh"
    CONDA_CHANGEPS1=false conda activate base
  else
    echo "source b"
    export PATH="/usr/local/google/home/christofa/opt/stow/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda init <<<
