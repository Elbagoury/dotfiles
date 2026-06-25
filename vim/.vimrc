set number  "Show the line numbers
set relativenumber
set t_Co=16
filetype plugin indent on
syntax on
set nowrap  "don't wrap long lines
set showcmd
set ignorecase  "case insensitiv search
set smartcase   "but not too insensitiv
set wildmenu
let g:netrw_liststyle=3     " tree view
let mapleader=" "
" auto install plugged
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
call plug#end()
set laststatus=2 " lightline
