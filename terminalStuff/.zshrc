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
MAVEN_OPTS="-Xmx1024m -Xms512m"
export MAVEN_OPTS


PATH=$PATH:/home/nwuensche/.gem/ruby/2.3.0/bin
export PATH
PATH=$PATH:/home/nwuensche/.gem/ruby/2.4.0/bin
export PATH
BROWSER=chromium
export BROWSER

(cd ~/Dokumente/Studium/4.Semester && wd add! stud)
(cd ~/InloopNoBackUp/inloop-tasks && wd add! shk)
(cd ~/Dokumente/Studium/4.Semester/HP/Versuch3 && wd add! hp)
(cd ~/Dokumente/Studium/4.Semester/Proseminar && wd add! pro)
(cd ~/.wine/drive_c/Program\ Files\ \(x86\)/ && wd add! wine)

alias saveDotFiles='

    git config --list | grep alias > ~/.dotFiles/gitStuff/gitaliases.txt;

	sudo cp /etc/hosts ~/.dotFiles/XStuff/hosts;
    sudo cp ~/.Xmodmap ~/.dotFiles/XStuff/.Xmodmap;
    sudo cp /usr/share/sddm/scripts/Xsetup ~/.dotFiles/XStuff/Xsetup;

	sudo cp ~/.vimrc ~/.dotFiles/vimStuff/.vimrc;
    sudo cp -r ~/.vim/snippets ~/.dotFiles/vimStuff;

	sudo cp ~/.bashrc ~/.dotFiles/terminalStuff/.bashrc;
	sudo cp ~/.zshrc ~/.dotFiles/terminalStuff/.zshrc;
    sudo cp -r ~/.oh-my-zsh/themes/agnoster.zsh-theme ~/.dotFiles/terminalStuff/agnoster.zsh-theme;

    sudo cp ~/.config/terminator/config ~/.dotFiles/terminalStuff/config.terminator;
    sudo cp ~/.config/ranger/rc.conf ~/.dotFiles/configs/rc.conf.ranger;

    sudo cp /etc/udev/rules.d/99-udisks2.rules ~/.dotFiles/rules/99-udisks2.rules;

    sudo realrm -r ~/.dotFiles/i3Stuff;
    sudo cp -r ~/.i3 ~/.dotFiles/i3Stuff;

    sudo realrm -r ~/.dotFiles/scripts;
    sudo cp -r ~/.scripts ~/.dotFiles/scripts;

    pacman -Qs > ~/.dotFiles/packages/packagesDescription.txt;
    pacman -Qeq > ~/.dotFiles/packages/packages.txt;

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
alias pacmanremoveorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias vscode='/usr/bin/code'
#alias intellij='sh /opt/IntelliJ\ Ultimate/bin/idea.sh'
alias transde="trans en:de -b"
alias transen="trans de:en -b"
alias emptytrash="sudo rm -rf ~/.local/share/Trash/*"
alias mkcd='f() { mkdir $1; cd $1 }; f'
alias getIt='f() { source ~/.dontDelete $1 }; f'
alias rm='echo "rm is disabled, use trash or realrm instead."'
alias realrm='/bin/rm'
alias xclip="xclip -selection c"
alias kcc='f() { kotlinc $1 -include-runtime -d program.jar; java -jar program.jar }; f'
alias youtubemp3='f() { (mkcd MusikDownloads; youtube-dl -f m4a $1; cp ~/.convertMusic.sh .; ./.convertMusic.sh;) }; f'
alias mv='mv -iv'
alias cp='cp -iv'
alias pdflatex='f() { (pdflatex $1; trash *.aux; trash *.log; trash *.nav; trash *.out; trash *.snm; trash *.toc) }; f'

clear

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nwuensche/.sdkman"
[[ -s "/home/nwuensche/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nwuensche/.sdkman/bin/sdkman-init.sh"
