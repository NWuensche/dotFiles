# Path to your oh-my-zsh installation.
export ZSH=/home/nwuensche/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git, wd)
source $ZSH/oh-my-zsh.sh

# User configuration
EDITOR=vim
export EDITOR
ANDROID_HOME=/home/nwuensche/Android/Sdk
export ANDROID_HOME

PATH=$PATH:/home/nwuensche/.gem/ruby/2.3.0/bin
export PATH
PATH=$PATH:/home/nwuensche/.gem/ruby/2.4.0/bin
export PATH
BROWSER=chromium
export BROWSER

alias saveDotFiles='
	sudo cp /etc/hosts ~/.dotFiles/XStuff/hosts;
    sudo cp ~/.Xmodmap ~/.dotFiles/XStuff/.Xmodmap;

	sudo cp ~/.vimrc ~/.dotFiles/vimStuff/.vimrc;

	sudo cp ~/.bashrc ~/.dotFiles/terminalStuff/.bashrc;
	sudo cp ~/.zshrc ~/.dotFiles/terminalStuff/.zshrc;
    sudo cp -r ~/.oh-my-zsh/themes/agnoster.zsh-theme ~/.dotFiles/terminalStuff/agnoster.zsh-theme;

    sudo cp /usr/share/sddm/scripts/Xsetup ~/.dotFiles/sddmStuff/Xsetup;

    sudo realrm -r ~/.dotFiles/i3Stuff;
    sudo cp -r ~/.i3 ~/.dotFiles/i3Stuff;

	cd ~/.dotFiles;
	sudo git add .;
	sudo git commit -m "(`date +%Y-%m-%d`) change dotFiles";
	sudo git push;
	cd;
'
alias -s sh=sh
alias -s txt=vim
alias -s tex=vim
alias -s html=chromium
alias -s pdf=chromium
alias pacman=yaourt
alias sudo='sudo ' # important, so that aliases work with sudo
alias pacmanremoveorhpans='sudo pacman -Rns $(pacman -Qtdq)'
alias vscode='/usr/bin/code'
alias intellij='sh /opt/IntelliJ\ Ultimate/bin/idea.sh'
alias transde="trans en:de -b"
alias transen="trans de:en -b"
alias emptytrash="sudo rm -rf ~/.local/share/Trash/*"
alias mkcd='f() { mkdir $1; cd $1 }; f'
alias getIt='f() { source ~/.dontDelete $1 }; f'
alias rm='echo "rm is disabled, use trash-put or realrm instead."'
alias realrm='/bin/rm'
alias xclip="xclip -selection c"
alias example='f() { echo Your arg was $1. };f'
alias kcc='f() { kotlinc $1 -include-runtime -d program.jar; java -jar program.jar }; f'

(cd ~/Dokumente/Studium/3.\ Semester && wd add! stud)
(wd stud && cd swt16w17/app && wd add! spr)

clear

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nwuensche/.sdkman"
[[ -s "/home/nwuensche/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nwuensche/.sdkman/bin/sdkman-init.sh"