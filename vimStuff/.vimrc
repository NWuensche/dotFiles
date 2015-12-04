set relativenumber

"PEP 80
highlight ColorColumn ctermbg=DarkCyan
call matchadd('ColorColumn', '\%81v', 100)


"" Vundle Begin
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" Powerline(When nothigns works
" Plugin 'bling/vim-airline'
" set laststatus=2


" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Solarized-Theme
Plugin 'altercation/vim-colors-solarized'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'"default snippets

" Latex
Plugin 'lervag/vimtex'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'xuhdev/vim-latex-live-preview'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"" Vundle End
"Solarized-Dependencies
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized
"Automatically open Snipmate for C
au BufNewFile,BufRead *.c SnipMateLoadScope c
"set filetype=r

