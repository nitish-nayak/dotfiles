"Nitish

"To remember for workflow (Why do I forget things so easily!) : 
"<leader>cc : comments visual block
"<leader>cy : comments and yanks visual block
"<leader>cu : uncomments visual block
"<space>    : opens fold
"<leader>l  : next buffer
"<leader>h  : previous buffer
"<leader>q  : close buffer
"<C-h,j,k,l>: moving between windows
":new,:vnew : new horizontal/vertical windows
"<leader>u  : undo tree
"<leader>s  : save sessions windows
"<leader>n  : next syntax error
"<leader>N  : previous syntax error
"]c,[c      : next and previous changes in vimdiff
"vi<>       : select text block between parentheses 
"ci<>       : change text block between parentheses 
":w!!       : write with sudo permissions

":Gstatus   : get status, press - to add files to index
":Gedit     : edit file in index
":Gvsplit   : open file in index in a vertical window and edit 
":Gcommit -m: commit index files to HEAD with message
":Gread     : read from HEAD (git checkout basically)
":Gwrite    : add to index when on work tree, checkout when on index
":Git <>    : git command 
":Gdiff     : git diff
"
" <C-f>     : bring up command history
" <S-Left>  : cursor one word left 
" <S-Right> : cursor one word right
" <C-b>     : cursor to beginning of command-line                                                                                                                                                     
" <C-e>     : cursor to end of command-line
" <C-w>     : delete word before cursor
" <C-u>     : delete all chars before cursor
" :<C-r> and below for command line options
"         '"'   the unnamed register, containing the text of the last delete or yank
"         '%'   the current file name
"         '#'   the alternate file name
"         '*'   the clipboard contents (X: primary selection)
"         ''    the clipboard contents
"         '/'   the last search pattern
"         ':'   the last command-line
"         '-'   the last small (less than a line) delete
"         '.'   the last inserted text
"         '='   the expression register

":CtrlP path: Change workspace for CtrlP, can also use :cd /path/to/dir
" <C-x>     : Open CtrlP files in new horizontal split  
" <C-v>     : Open CtrlP files in new vertical split  
" <C-n>     : Bring up NerdTree
"

"-------
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
"no compatibility
set nocompatible
"-------

"Vundle
"-------
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle')

"Vundle - required
Plugin 'VundleVim/Vundle.vim'
"Commenting
Plugin 'scrooloose/nerdcommenter'
"Get undo tree
Plugin 'sjl/gundo.vim'
"Command-T
Plugin 'wincent/command-t' 
"Ctrl-P
Plugin 'kien/ctrlp.vim'
"Status Bar
Plugin 'vim-airline/vim-airline'
"Python 
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
"Syntax Checking
Plugin 'scrooloose/syntastic'
"Git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
"NerdTree
Plugin 'scrooloose/nerdtree'
"Faster CtrlP
Plugin 'FelikZ/ctrlp-py-matcher'
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

"Misc
"-------
cmap w!! w !sudo tee > /dev/null %
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
"ignore files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
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
"buffer switching
map <leader>l :bn<CR>
map <leader>h :bp<CR>
map <leader>q :bd<CR>
"window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"copy to clipboard
map <C-c> "*y<CR>
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
let g:ctrlp_show_hidden=1
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"-------

"Airline
"-------
let g:airline#extensions#tabline#enabled = 1

"Jedi-Vim
"-------
let g:jedi#use_splits_not_buffers = "bottom"

"Syntastic
"-------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']

map <leader>n :lnext<CR>
map <leader>N :lprevious<CR>

"Fugitive
"-------
set statusline+=%{fugitive#statusline()}

"NerdTree
"-------
map <C-n> :NERDTreeToggle<CR>
