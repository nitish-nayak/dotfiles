"Nitish
":map
":help quickref

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
"set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
call vundle#begin('$HOME/.vim/bundle')

"Vundle - required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'benmills/vimux'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline' "keep
" Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab' "keep
" Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter' "keep
Plugin 'tpope/vim-fugitive' "keep
Plugin 'scrooloose/nerdtree'
Plugin 'FelikZ/ctrlp-py-matcher'
" Plugin 'tpope/vim-dispatch'

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
" set tabstop=4
set expandtab
set shiftwidth=2
set softtabstop=2
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
nnoremap ] %
"leader
let mapleader=","
"buffer switching
map <leader>] :bn<CR>
map <leader>[ :bp<CR>
map <leader>d :bd<CR>
"window management
map <leader>v <C-w>v
map <leader>s <C-w>s
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

"copy to clipboard
map <C-c> "*y<CR>

"regexp search - permanent
cnoremap s/ s/\v
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
nnoremap <leader>` :mksesssion<CR>

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

"Vimux
"-------
" map <leader>vp :VimuxPromptCommand<CR>
" map <Leader>vl :VimuxRunLastCommand<CR>

"Jedi-Vim
"-------
" let g:jedi#use_splits_not_buffers = "bottom"

"Syntastic
"-------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
"
" let g:syntastic_python_checkers = ['pylint']
"
" map <leader>n :lnext<CR>
" map <leader>N :lprevious<CR>

"Fugitive
"-------
set statusline+=%{fugitive#statusline()}

"NerdTree
"-------
map <C-n> :NERDTreeToggle<CR>

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.linenr = ' ln '
" let g:airline_symbols.colnr = ' cn '
"
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' ln '
let g:airline_symbols.colnr = ' cn '
