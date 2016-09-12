# Path to your oh-my-zsh installation.
export ZSH=/home/nwuensche/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git, wd)
(cd ~/Github/leksah && wd add! lek)
source $ZSH/oh-my-zsh.sh

# User configuration
SUDO_EDIT="vim"
EDITOR="Vim"
export SUDO_EDITOR
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
	sudo git push;
	cd;
'
alias -s sh=sh
alias -s txt=vim
alias -s tex=vim
alias -s html=firefox
alias pacman=yaourt
alias sudo='sudo ' # important, so that aliases work with sudo
mkcd (){mkdir $1; cd $1}
getIt (){source ~/.dontDelete $1}
(cd ~/Dokumente/Studium && wd add! stud)
(cd ~/Dokumente/Spring-Workspace && wd add! spr)
alias xclip="xclip -selection c"

clear
