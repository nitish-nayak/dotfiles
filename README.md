Run setup.sh to backup old config and symlink relevant dotfiles in the home directory
```
git clone https://github.com/nitish-nayak/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`setup.sh` runs through each folder given here, cd's into it and runs `install.sh`
Any required python modules are given in `pyrequirements.txt` for each folder.
`setup.sh` will also install them using `pip`

Require :
1. zsh
2. git
3. tmux
4. curl
5. vim
6. python
7. neovim

On an OSX host these are also installed automatically using homebrew. So just need to
```
git checkout osx
```
before running `./setup.sh`

Run `./setup.sh -p` optionally to install personal apps including [visp](https://github.com/ambientsound/visp) (requires `go`)
