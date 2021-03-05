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
"set clipboard=unnamedplus

set spell
set spelllang=en,de

syntax enable
let mapleader = ","
set rtp^=$SNIPPETSPATH

set splitright
set splitbelow

" Not formatting pasting
"set pastetoggle=<F10> 
"inoremap <Leader>p <F10><C-r>+<F10>

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
" Advanced Latex Plugin, does not fulfill my spelling needs tikz
"Plugin 'lervag/vimtex'
" Vim Hard Mode
"Plugin 'dusans/vim-hardmode'
" Git Plugin
"Plugin 'tpope/vim-fugitive'
" Close Brackets automaticaly
"Plugin 'Raimondi/delimitMate'
"Tmux Vim Windows Seamless
"Plugin 'christoomey/vim-tmux-navigator'
"Fuzzy Filenames
"Plugin 'ctrlpvim/ctrlp.vim'

"Nix Syntax
"Plugin 'LnL7/vim-nix'
"Typescript
"Plugin 'leafgarland/typescript-vim'
" Solarized-Theme
"Plugin 'altercation/vim-colors-solarized'
Plugin 'ericbn/vim-solarized'
" Fixing whitespaces
Plugin 'bronson/vim-trailing-whitespace'
" Markdown Folding
Plugin 'mikeboiko/vim-markdown-folding'
"INFO Original Markdown Plugin, but without fix for https://github.com/masukomi/vim-markdown-folding/issues/42
"Plugin 'nelstrom/vim-markdown-folding'
" Surround text with brackets
"Plugin 'tpope/vim-surround'
" Latex Preview in Okular
"Plugin 'xuhdev/vim-latex-live-preview'
" Allow Snippets(+Dependecies)
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
" Automatically delete swap file
"Plugin 'gioele/vim-autoswap'
" more grep, like Rgrep
"Plugin 'yegappan/grep'
"CSV Files
"Plugin 'chrisbra/csv.vim'
"Android
"Plugin 'hsanson/vim-android'
"Plugin 'udalov/kotlin-vim'
"Dart Lang syntax
"Plugin 'dart-lang/dart-vim-plugin'
"	------- PLUGINS END ------- "

call vundle#end()
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

" YouCompleteMe + Ultisnaps together
"let g:ycm_key_list_select_completion=[]
"let g:ycm_key_list_previous_completion=[]
let g:UltiSnipsSnippetsDir='/home/nwuensche/.dotFiles/vimStuff'
" My tmux overrides c-j
"let g:UltiSnipsJumpForwardTrigger="<c-d>"


"map <Leader>f :FZF <CR>

let g:snipMate = get(g:, 'snipMate', {})

let @t='gg/\[*\](E"adiwb"sdi(h"apcs([lxelxGGo["apA: "sp' " for Issue 39


"autocmd Filetype tex nnoremap <buffer> <F2> :! latexmk -pdf %:p <CR>
"autocmd Filetype md map <F2> :! pandoc %:p -o %:r.pdf <CR>
"map <F2> :! latexmk -pdf paper.tex<CR>
"au Filetype tex map <buffer><F2> :! latexmk -pdf %:p <CR>
" Filetype stuff doesn't work for some reason

" %:p:r is full path without file extension
" silent skips 'Press ENTER' prompt, but need to redraw screen afterwards because else it looks empty
autocmd BufRead,BufNewFile *.tex map <F3>  :w<CR> :silent !  vimCompileAndShowLatex %:p:r <CR> :redraw! <CR>
" line('.') is current Line number of cursor
autocmd BufRead,BufNewFile *.tex map <F2>  :w<CR> :silent exe '! fastLatexCompile ' . line('.') <CR> :redraw! <CR>
"<CR> :redraw! <CR>


autocmd BufRead,BufNewFile *.md map <F2> :! pandoc --filter pandoc-citeproc --bibliography=%:r.bib --csl=%:r.csl --variable papersize=a4paper --metadata link-citations=True -s %:p -o %:r.pdf <CR>

" Test File.py with FileT.py, `read` when error there
autocmd BufRead,BufNewFile *.py map <F2>  :w<CR> :silent !  pytest %:p:rT.%:e \|\| read <CR> :redraw! <CR>

" Dont autocomplete by looking through all 'include' files (e.g. boost)
" TODO Does not work, thus I just set complete globaly (Which works)
if &filetype == "cpp"
  set complete-=i
endif
if &filetype == "hpp"
  set complete-=i
endif
set complete-=i


"autocmd Filetype json :%!ownjsonTool --no-ensure-ascii
" Used for moving stuff inside tikz
xnoremap <leader>m <esc>:'<,'>!moveTikz -r 

"Swap Word Right/Left
"nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
"nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>w

"Autocomplete on Ctrl+Z
"imap <C-Z> <C-P>

" texvim needed, else error on start
"let g:tex_flavor = 'latex'

" Needed for .vim/ftplugin/tex.vim to be autoloaded for .vim files
let g:tex_flavor = 'latex'

"Exclude spellcheck in Latex Comments
let g:tex_comment_nospell=1

"Don't increase numbers accidentally when using tmux (latex + bibtex + Python)
nnoremap <C-a> <nop>

"Don't increase numbers accidentally when using tmux (latex + bibtex + Python)
inoremap <C-a> <nop>

