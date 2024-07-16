" Vundle mandatory configuration - START
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Air Line plugin
Plugin 'vim-airline/vim-airline'
" Air Line plugin themes
Plugin 'vim-airline/vim-airline-themes'

" Nerdtree plugin
Plugin 'preservim/nerdtree'

call vundle#end()            " required
filetype plugin indent on    " required
" Vundle mandatory configuration - END

" Sets the Airline Plugin Themee to angr
let g:airline_theme='angr'

" sets the theme the be dark
set bg=dark

" sets line numbers
set number

" sets relative line numbers
set relativenumber

" sets highlighting when searching
set hlsearch

" sets searches to be incremental
set incsearch

" sets the tabs to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" converts our tab to spaces
set expandtab
set autoindent
set fileformat=unix

" yanking goes to system clipboard
set clipboard=unnamedplus
vnoremap <C-c> "+y
map <C-p> "+p

" enables syntax highlighting
syntax on

" sets the encoding to UTF-8
set encoding=utf-8

" splits the screen directly on the right instead of below, which is the default behaviour in VIM
set splitbelow splitright

" Remaps S to global replace :%s//g
nnoremap S :%s//g<Left><Left>

" shortcuts to quickly go through the different split screens
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" remaps the new tab key combination
nnoremap <silent> <C-t> :tabnew<CR>

" remaps the ctrl-d and ctrl-u to always put the cursor in the middle of the
" screen
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" sets autocomplete - use ctrl-n to activate
set wildmode=longest,list,full

"Aitomatically deletes all trailing whitespaxes on save
autocmd BufWritePre * %s/\s\+$//e

" sets the possibility to go left, right, up and down with the cursor in insert mode
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

