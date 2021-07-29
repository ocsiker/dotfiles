"config my vimrc ocsiker
set relativenumber
set nu
"turn on syntax
set ttimeoutlen=0
syntax on
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
"set termguicolors


let leader=' '
call plug#begin()
"Plug 'junegunn/vim-easy-align'
"for font
Plug 'morhetz/gruvbox' "vim tmux nagivator
"Plug 'jremmen/vim-ripgrep'
"for git
Plug 'tpope/vim-fugitive' "Plug 'mbbill/undotree'
"Plug 'leafgarland/typescript-vim'
"Plug 'vim-utils/vim-man'
"Plug 'lyuts/vim-rtags'
"tree sitter use TSInstall {language}
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'neovim/nvim-lspconfig'
"Plug 'norcalli/snippets.nvim'
"Plug 'williamboman/nvim-lsp-installer'
"Plug 'kabouzeid/nvim-lspinstall'
"Plug 'glepnir/lspsaga.nvim'
"auto Format code

"auto complete & format code
"Plug 'Chiel92/vim-autoformat'
" Add maktaba and codefmt to the runtimepath.
" 
 
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'

Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

"Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'

"vim surround
Plug 'tpope/vim-surround'
"delimitMate auto pair { " ;
"Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'
"tmux vim key
Plug 'christoomey/vim-tmux-navigator'

"color light
 "Plug 'itchyny/lightline.vim'
 "for airline
 Plug 'vim-airline/vim-airline'

"html css complete
Plug 'mattn/emmet-vim' " We recommend updating the parsers on update
"Nerdtree
Plug 'preservim/nerdtree'

"Plug for coc
Plug 'neoclide/coc.nvim', { 'branch' : 'release' }

"track engine for snippets
"Plug 'SirVer/ultisnips'
"colorizer for css scss
"Plug 'norcalli/nvim-colorizer.lua'
Plug 'ap/vim-css-color'
"Plug snippets
Plug 'honza/vim-snippets'

"select multilines
Plug 'terryma/vim-multiple-cursors'
call plug#end()

colorscheme gruvbox
set background=dark

nnoremap s <Nop>
nnoremap sw :w <cr>
nnoremap sv :source % <cr>

"compe-nvim
"set completeopt=menuone,noselect

"for Nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>


"Use Python in NEOVIM
let g:python3_host_prog="/usr/bin/python3.8"

"auto format code
noremap <F3> :Autoformat<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
                        \ pumvisible() ? "\<C-n>" :
                        \ <SID>check_back_space() ? "\<Tab>" :
                        \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <c-space> to trigger completion.
if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
else
        inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"for jump next placeholder
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"list CocInstall coc-json coc-tsserver
"Enable to highlight current symbol
autocmd CursorHold * silent call CocActionAsync('highlight')




"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0


"install vim-jsonc for COC-NEOVIM
autocmd FileType json syntax match Comment +\/\/.\+$+


nnoremap cocs :CocCommand snippets.openSnippetFiles <cr> 

"resize vim windows
nnoremap rs :vertical resize 80

"change key Emmet
let g:user_emmet_leader_key = '<C-e>'

nnoremap <C-y> "+y
nnoremap <C-p> "+p
"Delimate vim disable <> to < 
"let g:delimitMate_matchpairs='(:),[:],{:}'
"au FileType html let b:delimitMate_matchpairs='(:),[:],{:},<:>'
"make normal tab jump to end of line

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
 "   Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

"let g:prettier#config#semi='false'
nnoremap <Tab> f<Space>
nnoremap ci" f"ci"
nnoremap ci' f'ci'
nnoremap ci( f(ci(
nnoremap ci{ f{ci{
nnoremap ci[ f[ci[
nnoremap di" F"ci"
nnoremap di' F'ci'
nnoremap di( F(ci(
nnoremap di{ F{ci{
nnoremap di[ F[ci[
