# Path to your oh-my-zsh installation.
export ZSH=/home/nwuensche/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, wd)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
eval `dircolors ~/.solarized/dircolors.ansi-dark`q
#alias cdStud='cd ~/Dokumente/Studium'
alias saveDotFiles='
	sudo rm -r ~/.dotFiles/vimStuff/.vim;
	sudo cp -r ~/.vim ~/.dotFiles/vimStuff;
	sudo cp ~/.vimrc ~/.dotFiles/vimStuff/.vimrc;
	sudo cp ~/.bashrc ~/.dotFiles/XStuff/.bashrc;
	sudo cp ~/.zshrc ~/.dotFiles/XStuff/.zshrc;
	sudo cp /etc/hosts ~/.dotFiles/XStuff/hosts;
	sudo rm -r ~/.dotFiles/i3Stuff/.i3  ;
	sudo cp -r ~/.i3 ~/.dotFiles/i3Stuff/.i3;
	cd ~/.dotFiles;
	sudo git add .;
	sudo git commit -m "(`date +%Y-%m-%d`) change dotFiles";
	sudo git push
'
alias startRadio='mocp http://streams.radiopsr.de/psr-live/mp3-192/mediaplayer'
#alias update='sudo apt update'
#alias upgrade='sudo apt upgrade'
alias -s sh=sh
alias -s txt=vim
alias -s tex=vim
alias -s html=firefox
alias pacman=yaourt
alias sudo='sudo ' # important, so that aliases work with sudo
#alias steam='LD_PRELOAD="/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so" steam'
mkcd (){mkdir $1; cd $1}
getIt (){source ~/.dontDelete $1}
(cd ~/Dokumente/Studium && wd add! stud && clear)
alias xclip="xclip -selection c"
