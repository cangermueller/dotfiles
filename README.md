# Dotfiles

My dotfiles managed by [dotdrop](https://github.com/deadc0de6/dotdrop).

<img src='/images/iterm.png' width=768 height=432></img>

## Installation
```bash
git clone https://github.com/cangermueller/dotfiles.git`
cd dotfiles
bash ./dotdrop.sh install -p base
```

### Fuzzy finder
See [fzf](https://github.com/junegunn/fzf) for mode details.
```bash
cd dotfiles/fzf
./install
```

# Vim modules
```bash
vundle: vim +PluginClean! +PluginInstall +PluginInstall! +qall
```

# Tmux plugins:
1. Install cmake, which is required by[tmux-mem-cpu-load](https://github.com/thewtex/tmux-mem-cpu-load):
```bash
sudo port install cmake
```
2. Press `C-s I` in an open tmux session. Plugins will be installed.
