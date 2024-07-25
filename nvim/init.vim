"*****************************************************************************
"" vim-plug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'mhartington/oceanic-next'

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" statusline
Plug 'vim-airline/vim-airline'

" telescope
" use with rg, fd, bat
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

" lsp
Plug 'neovim/nvim-lspconfig'

"completion engine
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" snippets and snippet engines
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" mason package manager
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" linting
" use with pylint, shellcheck, (maybe cppcheck)
Plug 'mfussenegger/nvim-lint'

" zen mode
Plug 'folke/zen-mode.nvim'

" toggleterm
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" undo tree
Plug 'mbbill/undotree'

" vim motions
Plug 'folke/flash.nvim'
call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

"" Map leader to ,
let mapleader=','

"" Searching
set ignorecase
set smartcase
set incsearch
"highlight matches
set hlsearch
"Ignore case
set ignorecase
"turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"" Directories for swp files
set noswapfile

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
"Toggle showing line numbers
nmap ~ :set number! number?<cr>

colorscheme OceanicNext

" show linenos
set number
" highlight current line
set cursorline
"show command in bottom bar
set showcmd
"filetype specific indentation
filetype indent on
"highlight matching parentheses
set showmatch
"visual autocomplete
set wildmenu

"*****************************************************************************
"" Miscellaneous
"*****************************************************************************

" forgot to sudo in
cmap w!! w !sudo tee > /dev/null %

" wildmode
set wildmenu
set wildmode=longest:full
set wildignore+=*.a,*.o,*.hi
set wildignore+=*.pdf,*.gz,*.aux,*.out,*.nav,*.snm,*.vrb
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"*****************************************************************************
"" Abbreviations
"*****************************************************************************

"" no one is really happy until you have these shortcuts
cnoreabbrev E e
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
"" Movement
"*****************************************************************************

"move by visual line
nnoremap j gj
nnoremap k gk

"move to beginning/end of line/script
noremap A ^
noremap D $
noremap W gg
noremap S GG
nnoremap ^ <nop>
nnoremap $ <nop>
nnoremap ] %

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

"disable mouse
set mouse=
"copy to clipboard
vnoremap <C-c> "+y

"*****************************************************************************
"" Plugins
"*****************************************************************************

"" vim-fugitive
" set statusline+=%{fugitive#statusline()}
noremap <Leader>gs :Git<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gh :.GBrowse<CR>
vnoremap <Leader>gh :.GBrowse<CR>

" vim-gitgutter
noremap <Leader>gt :GitGutterBufferToggle<CR>

" telescope
nnoremap <leader>ff  <cmd>Telescope find_files<cr>
nnoremap <leader>fg  <cmd>Telescope live_grep<cr>
nnoremap <leader>ft  <cmd>Telescope grep_string search="" only_sort_text=true shorten_path=true<CR>
nnoremap <leader>fb  <cmd>Telescope buffers<cr>
nnoremap <leader>fo  <cmd>Telescope oldfiles<cr>
" use telescope to check keymaps at any time
" need to open a certain filetype to show keymaps for lsp
nnoremap <leader>fk  <cmd>Telescope keymaps<cr>

" " airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' ln '
let g:airline_symbols.colnr = ' cn '

"nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:NERDTrimTrailingWhitespace=1
let g:NERDCommentEmptyLines=1

"whitespace
noremap <leader>ws :FixWhitespace<CR>

"treesitter (folding and statusline)
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.
"open most folds by default. 0-none, 99-all
set foldlevelstart=10
"max nested folds
set foldnestmax=10
"open/close folds
nnoremap <S-f> za

" undo tree
nnoremap <leader>u :UndotreeToggle<CR>

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" Zen mode
noremap :z :ZenMode <CR>

"*****************************************************************************
"" Language configs
"*****************************************************************************

" indent
autocmd FileType python,html,javascript,javascript.jsx setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType c,cpp,scala,java,ruby setlocal tabstop=2 shiftwidth=2 expandtab
<<<<<<< HEAD
" detect C files as cpp
autocmd BufNewFile,BufRead *.C setfiletype cpp
=======
" detect fcl files as json (temporarily until I finish writing a treesitter
" parser)
autocmd BufNewFile,BufRead *.fcl setfiletype yaml
>>>>>>> 0bf6955 (changes to get clangd lsp running for root macros)

"*****************************************************************************
" lua
"*****************************************************************************
lua require('telescope_config')
lua require('cmp_config')
lua require('lsp_config')
lua require('lint_config')
lua require('toggleterm_config')
lua require('flash_config')
lua require('root_config')
