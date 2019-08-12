set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamedplus
set spell


" New split always below current window
set splitbelow 
syntax enable
let mapleader = ","
set rtp^=$SNIPPETSPATH
set spelllang=en,de
" Show Line Number
set number

" Type <Leader>w to save file
nnoremap <Leader>w :w<CR>
"inoremap <Leader>p <c-r>+
" Not formating pasting
set pastetoggle=<F10>
inoremap <Leader>p <F10><C-r>+<F10>

nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap q: :q

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
" Vim symbol renderer
Plugin 'lervag/vimtex'
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
Plugin 'altercation/vim-colors-solarized'
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
"	------- PLUGINS END ------- "

call vundle#end()
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()
filetype plugin indent on
"	------- VUNDLE END ------- "
"
filetype plugin indent on
syntax on



set background=dark
colorscheme solarized
set t_Co=256 "Fix color solarized

"let g:UltiSnipsExpandTrigger="<c-j>"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
"let g:UltiSnipsSnippetsDir='~/UltiSnips'
let g:UltiSnipsSnippetsDir='/home/nwuensche/.dotFiles/vimStuff'

map <Leader>f :FZF <CR>
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>""

"Blue after 120 chars
"highlight ColorColumn ctermbg=DarkCyan
"call matchadd('ColorColumn', '\%121v', 100)

" Automatically load PDF preview on tex Files - Take out because Bibliography
" doesn't work
"autocmd Filetype tex call StartPDF()
"function StartPDF()
"    LLPStartPreview
"    call feedkeys ("\<return>")
"endfunction

let g:snipMate = get(g:, 'snipMate', {})

let @t='gg/\[*\](E"adiwb"sdi(h"apcs([lxelxGGo["apA: "sp' " for Issue 39

" Capitalize Word
nmap gcw guw~h
" Decapitalize Word
nmap gcc guu~h
"Compile current file (Full Path)
map <F2> :! latexmk -pdf %:p <CR>

autocmd Filetype json :%!ownjsonTool --no-ensure-ascii
" Used for moving stuff inside tikz
xnoremap <leader>m <esc>:'<,'>!moveTikz -r 
map <leader>n :sp %:p:h/macros.tex <CR>
"xnoremap <leader>n <esc>:'<,'>!scaleTikz -u -
"Swap Word Right/Left
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>w
"Italic TMUX
set t_ZH=[3m
set t_ZR=[23m

"Vimtex Plugin
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"Fix previous spelling error auto
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"Autocomplete on Ctrl+Z
imap <C-Z> <C-P>
"Inkscape Create
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
