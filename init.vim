"config my vimrc ocsiker

set relativenumber
set nu
syntax on   #turn on syntax
set tabstop=4
set autoindent
set expandtab
set softtabstop=4
set ignorecase
set smartcase
set nohlsearch
set incsearch
set showmatch
set colorcolumn=80
set signcolumn=yes
set smartindent

let leader=' '
call plug#begin()
"Plug 'junegunn/vim-easy-align'
"for font
Plug 'morhetz/gruvbox'
"vim tmux nagivator
"Plug 'jremmen/vim-ripgrep'
"for git
Plug 'tpope/vim-fugitive'
"Plug 'mbbill/undotree'
"Plug 'leafgarland/typescript-vim'
"Plug 'vim-utils/vim-man'
"Plug 'lyuts/vim-rtags'
"Plug 'git@github.com:kien/ctrlp.vim.git'
"Plug 'git@github.com:Valloric/YouCompleteMe.git'
"tree sitter use TSInstall {language}
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'neovim/nvim-lspconfig'
"Plug 'kabouzeid/nvim-lspinstal'
"Plug 'williamboman/nvim-lsp-installer'
"Plug 'glepnir/lspsaga.nvim'
"auto Format code

Plug 'christoomey/vim-tmux-navigator'

"auto complete & format code
Plug 'Chiel92/vim-autoformat'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'

" We recommend updating the parsers on update
"Nerdtree
Plug 'preservim/nerdtree'

Plug 'mattn/emmet-vim'

call plug#end()

colorscheme gruvbox
set background=dark

nnoremap sv : source % <cr>
nnoremap sw : w<cr>

"compe-nvim
set completeopt=menuone,noselect

"for Nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


"Use Python in NEOVIM
let g:python3_host_prog="/usr/bin/python3.8"

"auto format code
noremap <F3> :Autoformat<CR>
map <C-K> :py3f /usr/share/clang/clang-format-10/clang-format.py<CR>
au BufWrite * :Autoformat
