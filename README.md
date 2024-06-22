Run setup.sh to backup old config and symlink relevant dotfiles in the home directory
```
git clone https://github.com/nitish-nayak/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`setup.sh` runs through each folder given here, cd's into it and runs `install.sh`
Any required python modules are given in `pyrequirements.txt` for each folder.
`setup.sh` will also install them using `pip`

Require : `zsh`, `git`, `tmux`, `curl`, `vim`, `python`, `neovim`

On an OSX/Ubuntu host these are all installed automatically using homebrew. So just need to run `./setup.sh`

Run `./setup.sh -p` optionally to install personal apps including [visp](https://github.com/ambientsound/visp) (requires `go`)
