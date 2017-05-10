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
" Solarized-Theme
Plugin 'altercation/vim-colors-solarized'
" Fixing whitespaces
Plugin 'bronson/vim-trailing-whitespace'
" Markdown Folding
Plugin 'nelstrom/vim-markdown-folding'
" Surround text with brackets
Plugin 'tpope/vim-surround'
" Latex Preview in Okular
Plugin 'vim-latex-live-preview'
" Allow Snippets(+Dependecies)
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
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
