# Dotfiles

My dotfiles managed by [dotdrop](https://github.com/deadc0de6/dotdrop).

<img src='/images/iterm.png' width=768 height=432></img>

## Installation

The following tools must be install first:
* Python3 ([Anaconda](https://www.anaconda.com/download/#macos))
* [docopt](https://github.com/docopt/docopt) (`pip install docopt`)

### Dotfiles
1. Clone the repository and install the profile `base`:
```bash
git clone https://github.com/cangermueller/dotfiles.git`
cd dotfiles
bash ./dotdrop.sh install -p base
```

2. Add `source ~/.bash_profile` to `~/.profile`.
3. Add `source ~/.dotrc` to `~/.bash_profile`.


### Fuzzy finder
See [fzf](https://github.com/junegunn/fzf) for mode details.
```bash
cd dotfiles/fzf
./install
```

### Vim modules
```bash
vundle: vim +PluginClean! +PluginInstall +PluginInstall! +qall
```

### Tmux plugins:
1. Install cmake, which is required by [tmux-mem-cpu-load](https://github.com/thewtex/tmux-mem-cpu-load):
```bash
sudo port install cmake
```
2. Press `C-s I` in an open tmux session. Plugins will be installed.


## OSX dotfiles

### iterm
1. Open preferences.
2. Set 'Load preferences from custom folder or url to'  `dotfiles/iterm`.
