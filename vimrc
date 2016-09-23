"Nitish
"-------
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
"no compatibility
set nocompatible
"-------

"Vundle
"-------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
"Get undo tree
Plugin 'sjl/gundo.vim'
"Command-T
Plugin 'wincent/command-t' 
"Ctrl-P
Plugin 'kien/ctrlp.vim'
"Status Bar
Plugin 'vim-airline/vim-airline'

"All of your Plugins must be added before the following line
call vundle#end()           
filetype plugin indent on  
"To ignore plugin indent changes, instead use:
"filetype plugin on
"
"Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"-------

"Colors
"-------
syntax on
colorscheme badwolf
"-------

"Spaces
"-------
set tabstop=4
set softtabstop=4
set expandtab
"-------

"UI
"-------
"show line numbers
set number
"highlight current line
set cursorline
"show command in bottom bar
set showcmd
"filetype specific indentation
filetype indent on
"highlight matching parentheses
set showmatch
"visual autocomplete
set wildmenu
"-------

"Search
"-------
"search as characters are entered
set incsearch
"highlight matches
set hlsearch
"Ignore case
set ignorecase
"turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
"-------

"Folding
"-------
"enable folding
set foldenable
"open most folds by default. 0-none, 99-all
set foldlevelstart=10
"max nested folds
set foldnestmax=10
"open/close folds
nnoremap <space> za
"fold on indent : python
set foldmethod=indent
"-------

"Movement
"-------
"move by visual line
nnoremap j gj
nnoremap k gk
"move to beginning/end of line/script
nnoremap A ^
nnoremap D $
nnoremap W gg
nnoremap S GG
nnoremap ^ <nop>
nnoremap $ <nop>
"leader
let mapleader=","
"-------

"Comments
"-------
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:NERDTrimTrailingWhitespace=1
let g:NERDCommentEmptyLines=1
"-------


nnoremap <leader>u :GundoToggle<CR>
"save session
nnoremap <leader>s :mksesssion<CR>

"CtrlP
"-------
let g:ctrlp_max_files=0
"-------

"Airline
"-------

let g:airline#extensions#tabline#enabled = 1
