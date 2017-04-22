set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set spell
syntax enable
let mapleader = "\<Space>"
set spelllang=en,de

" Type <Leader>w to save file
nnoremap <Leader>w :w<CR>

" Disable arrow keys in insert mode
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Stop Ex-Mode
nnoremap Q <nop>

" 	------- VUNDLE BEGIN ------- "
set nocompatible              " be iMproved, required
filetype off                  " required
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 	------- PLUGINS BEGIN ------- "
" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
" Close Brackets automaticaly
Plugin 'Raimondi/delimitMate'
"NerdTree
Plugin 'scrooloose/nerdtree'
" Solarized-Theme
Plugin 'altercation/vim-colors-solarized'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Comment fast
Plugin 'scrooloose/nerdcommenter'
" Fixing whitespaces
Plugin 'bronson/vim-trailing-whitespace'
" Kotlin Syntax
Plugin 'udalov/kotlin-vim'
" JS Syntax
Plugin 'pangloss/vim-javascript'
" Markdown Folding
Plugin 'nelstrom/vim-markdown-folding'
" Surrond text with brackets
Plugin 'tpope/vim-surround'
"	------- PLUGINS END ------- "

call vundle#end()            " required
filetype plugin indent on    " required
"	------- VUNDLE END ------- "

set background=dark
colorscheme solarized

"Blue after 120 chars
highlight ColorColumn ctermbg=DarkCyan
call matchadd('ColorColumn', '\%121v', 100)

nmap <leader><leader> :NERDTreeToggle<CR>
nmap <F5> :!make <CR>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
