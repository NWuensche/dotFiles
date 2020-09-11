
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>


"No Deleting in Insert Mode
inoremap <BS> <Nop>
inoremap <Del> <Nop>

set relativenumber
set number

set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamedplus

set spell
set spelllang=en,de

set splitbelow
syntax enable
let mapleader = ","
set rtp^=$SNIPPETSPATH

set splitbelow

" Not formatting pasting
set pastetoggle=<F10> 
inoremap <Leader>p <F10><C-r>+<F10>

" Stop Ex-Mode
nnoremap Q <nop>

"TODO Fix
nnoremap q: :q

" 	------- VUNDLE BEGIN ------- "
set nocompatible              " be iMproved, required
filetype off                  " required
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 	------- PLUGINS BEGIN ------- "
" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
" Vim symbol renderer
Plugin 'lervag/vimtex'
" Vim Hard Mode
Plugin 'dusans/vim-hardmode'
" Git Plugin
Plugin 'tpope/vim-fugitive'
" Close Brackets automaticaly
Plugin 'Raimondi/delimitMate'
"Tmux Vim Windows Seamless
Plugin 'christoomey/vim-tmux-navigator'
"Fuzzy Filenames
Plugin 'ctrlpvim/ctrlp.vim'

"Nix Syntax
Plugin 'LnL7/vim-nix'
"Typescript
Plugin 'leafgarland/typescript-vim'
" Solarized-Theme
"Plugin 'altercation/vim-colors-solarized'
Plugin 'ericbn/vim-solarized'
" Fixing whitespaces
Plugin 'bronson/vim-trailing-whitespace'
" Markdown Folding
Plugin 'nelstrom/vim-markdown-folding'
" Surround text with brackets
Plugin 'tpope/vim-surround'
" Latex Preview in Okular
Plugin 'xuhdev/vim-latex-live-preview'
" Allow Snippets(+Dependecies)
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
" Automatically delete swap file
"Plugin 'gioele/vim-autoswap'
" more grep, like Rgrep
Plugin 'yegappan/grep'
"CSV Files
Plugin 'chrisbra/csv.vim'
"Android
"Plugin 'hsanson/vim-android'
Plugin 'udalov/kotlin-vim'
"Dart Lang syntax
Plugin 'dart-lang/dart-vim-plugin'
"	------- PLUGINS END ------- "

call vundle#end()
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()
filetype plugin indent on
"	------- VUNDLE END ------- "
"

set background=dark
colorscheme solarized
"Fix color solarized
set t_Co=256 

"Italic TMUX
set t_ZH=[3m
set t_ZR=[23m

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:UltiSnipsSnippetsDir='/home/nwuensche/.dotFiles/vimStuff'
" My tmux overrides c-j
let g:UltiSnipsJumpForwardTrigger="<c-d>"


map <Leader>f :FZF <CR>

let g:snipMate = get(g:, 'snipMate', {})

let @t='gg/\[*\](E"adiwb"sdi(h"apcs([lxelxGGo["apA: "sp' " for Issue 39

filetype plugin on

"autocmd Filetype tex nnoremap <buffer> <F2> :! latexmk -pdf %:p <CR>
"autocmd Filetype md map <F2> :! pandoc %:p -o %:r.pdf <CR>
"map <F2> :! latexmk -pdf paper.tex<CR>
"au Filetype tex map <buffer><F2> :! latexmk -pdf %:p <CR>
" Filetype stuff doesn't work for some reason

" %:p:r is full path without file extension
" silent skips 'Press ENTER' prompt, but need to redraw screen afterwards because else it looks empty
autocmd BufRead,BufNewFile *.tex map <F2>  :w<CR> :silent !  vimCompileAndShowLatex %:p:r <CR> :redraw! <CR>


autocmd BufRead,BufNewFile *.md map <F2> :! pandoc --filter pandoc-citeproc --bibliography=%:r.bib --csl=%:r.csl --variable papersize=a4paper --metadata link-citations=True -s %:p -o %:r.pdf <CR>

" Test File.py with FileT.py, `read` when error there
autocmd BufRead,BufNewFile *.py map <F2>  :w<CR> :silent !  pytest %:p:rT.%:e \|\| read <CR> :redraw! <CR>



"autocmd Filetype json :%!ownjsonTool --no-ensure-ascii
" Used for moving stuff inside tikz
xnoremap <leader>m <esc>:'<,'>!moveTikz -r 

"Swap Word Right/Left
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>w

"Autocomplete on Ctrl+Z
imap <C-Z> <C-P>

" texvim needed, else error on start
let g:tex_flavor = 'latex'
