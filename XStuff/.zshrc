# Path to your oh-my-zsh installation.
export ZSH=/home/nwuensche/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git, wd)
source $ZSH/oh-my-zsh.sh

# User configuration
EDITOR=vim
export EDITOR

PATH=$PATH:/home/nwuensche/.gem/ruby/2.3.0/bin
export PATH

alias saveDotFiles='
	sudo rm -r ~/.dotFiles/vimStuff/.vim;
	sudo cp -r ~/.vim ~/.dotFiles/vimStuff;
	sudo cp ~/.vimrc ~/.dotFiles/vimStuff/.vimrc;
	sudo cp ~/.bashrc ~/.dotFiles/XStuff/.bashrc;
	sudo cp ~/.zshrc ~/.dotFiles/XStuff/.zshrc;
	sudo cp /etc/hosts ~/.dotFiles/XStuff/hosts;
	sudo rm -r ~/.dotFiles/i3Stuff/.i3  ;
	sudo cp -r ~/.i3 ~/.dotFiles/i3Stuff/.i3;
    sudo cp -r ~/.oh-my-zsh/themes/agnoster.zsh-theme ~/.dotFiles/agnoster.zsh-theme;
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
rm (){trash-put $1;}
realrm (){rm $1;}
(cd ~/Dokumente/Studium/3.\ Semester && wd add! stud)
(wd stud && cd swt16w17/app && wd add! spr)
(wd stud && cd Lebenslauf\ für\ Englisch\ -\ MLP\ schon\ auf\ Externer/MLP\ Stipendium\ Wiesloch\ 2016/Lebenslauf && wd add! eng)

alias xclip="xclip -selection c"
clear
