" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" solarized
Plugin 'altercation/vim-colors-solarized'
" Markdown + live preview
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Powerline für Vim
Plugin 'bling/vim-airline'
set laststatus=2
" Nerdtree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" Strg n öffnet Nerdtree
map <C-n> :NERDTreeToggle<CR>
" tmux-vim 
Plugin 'christoomey/vim-tmux-navigator'
" vim-late
Plugin 'lervag/vimtex'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'xuhdev/vim-latex-live-preview'
" Automatisch bei start nerdtree öffnen
"autocmd vimenter * NERDTree
"Alet g:airline_powerline_fonts = 1
"Plugin 'Lokaltog/vim-powerline'
"let g:Powerline_symbols = 'fancy'
" Git Integration
Plugin 'tpope/vim-fugitive'
" Powerline 2
"Plugin 'itchyny/lightline.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Git plugin not hosted on GitHub
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Avoid a name conflict with L9

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set t_Co=256
syntax enable
set background=dark
colorscheme solarized
" set Colors
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_termcolors=256
colorscheme solarized 
" test
"PowerLine Pfeil
: set number
: set relativenumber
" colorcolumn
highlight ColorColumn ctermbg=DarkCyan
call matchadd('ColorColumn', '\%81v', 100)
" i3
noremap j h
noremap k j
noremap l k
noremap ö l
