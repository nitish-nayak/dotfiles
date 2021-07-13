#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles_backup
files="bashrc bash_aliases vimrc tmux.conf zshrc"


# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [ "$file" == "bashrc" ]; then
            echo "source $dir/$file" >> ~/.$file
    else        
            if [ -f "$HOME/.$file" ]; then  
                    echo "Moving any existing dotfiles from ~ to $olddir"
                    mv ~/.$file ~/dotfiles_backup/
            fi
            echo "Creating symlink to $file in home directory."
            ln -s $dir/$file $HOME/.$file
    fi
done

file="./nitish_robbyrussell_modified.zsh-theme"
if [[ -f "$file" ]]; then
  echo "Copying custom ZSH theme"
  cp "$file" ~/.oh-my-zsh/themes/.
fi
