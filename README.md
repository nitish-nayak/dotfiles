Run setup.sh to backup old config and symlink relevant dotfiles in the home directory
```
 git clone https://github.com/nitish-nayak/dotfiles.git ~/dotfiles
 cd ~/dotfiles
./setup.sh
```

`setup.sh` runs through each folder given here, cd's into it and runs `requirements.sh`

Require : 
1. zsh
2. git
3. tmux
4. vim
5. curl
6. neovim
7. python for neovim (with modules defined in nvim/requirements.txt) 
