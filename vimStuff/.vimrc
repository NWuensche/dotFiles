set relativenumber
set tabstop=4
set shiftwidth=4 
set expandtab
"let g:hardtime_default_on = 1




"" Vundle Begin
set nocompatible              " be iMproved, required
filetype off                  " required
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" let Vundle manage Vundle, required
" Close Brackets automaticaly
Plugin 'Raimondi/delimitMate'
"NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'VundleVim/Vundle.vim'
" Solarized-Theme
Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'
" Plugin 'wikitopian/hardmode'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Snipmate
Plugin 'takac/vim-hardtime'
"Plugin 'wikitopian/hardmode'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
"default snippets
Plugin 'honza/vim-snippets'
" Comment fast
Plugin 'scrooloose/nerdcommenter'
" Pop-up Menu Completion(Python)
"Plugin 'davidhalter/jedi-vim'
" YouCompleteMe
"Plugin 'Valloric/YouCompleteMe'
"Powerline
"Plugin 'bling/vim-airline'
" Fixing whitespaces
Plugin 'bronson/vim-trailing-whitespace'
" Latex
Plugin 'lervag/vimtex'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'xuhdev/vim-latex-live-preview'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"" Vundle End
"Solarized-Dependencies
"let g:solarized_termtrans=1
"let g:solarized_contrast="high"
"let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized
"Automatically open Snipmate for C
au BufNewFile,BufRead *.c SnipMateLoadScope c
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 2
"PowerLine Stuff
set laststatus=2
let g:airline_powerline_fonts = 1
"paste-mod
set pastetoggle=<F2>
let mapleader = "\<Space>"
"PEP 80
highlight ColorColumn ctermbg=DarkCyan
call matchadd('ColorColumn', '\%81v', 100)
" Stop Ex-Mode 
nnoremap Q <nop>
"colorscheme Monokai
nmap <leader>d :NERDTreeToggle<CR>

"F5 to make
nmap <F5> :!make <CR>
