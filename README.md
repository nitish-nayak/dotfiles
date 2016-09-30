Run link.sh to backup old dotfiles and symlink dotfiles in home directory
```
 cd ~/dotfiles
 chmod +x link.sh
./link.sh
```
To install vim plugins, first install Vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
then install in vim with 
```
:BundleInstall
```
or from commandline 
```
vim +PluginInstall +qall
```
To enable colorschemes in vim copy appropriate file into .vim/colors
