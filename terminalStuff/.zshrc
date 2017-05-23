# Path to your oh-my-zsh installation.
export ZSH=/home/nwuensche/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git)
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

alias saveDotFiles='

    git config --list | grep alias > ~/.dotFiles/gitStuff/gitaliases.txt;

	realcp /etc/hosts ~/.dotFiles/XStuff/hosts;
    realcp ~/.Xmodmap ~/.dotFiles/XStuff/.Xmodmap;
    realcp /usr/share/sddm/scripts/Xsetup ~/.dotFiles/XStuff/Xsetup;

	realcp ~/.vimrc ~/.dotFiles/vimStuff/.vimrc;
    realcp -r ~/.vim/snippets ~/.dotFiles/vimStuff;
    realcp ~/.vim/bundle/vim-autoswap/plugin/autoswap.vim ~/.dotFiles/vimStuff/autoswap.vim

	realcp ~/.bashrc ~/.dotFiles/terminalStuff/.bashrc;
	realcp ~/.zshrc ~/.dotFiles/terminalStuff/.zshrc;
    realcp -r ~/.oh-my-zsh/themes/agnoster.zsh-theme ~/.dotFiles/terminalStuff/agnoster.zsh-theme;

    realcp ~/.config/terminator/config ~/.dotFiles/configs/config.terminator;
    realcp ~/.config/ranger/rc.conf ~/.dotFiles/configs/rc.conf.ranger;
    realcp ~/.config/ranger/rifle.conf ~/.dotFiles/configs/rifle.conf.ranger;

    realcp /etc/udev/rules.d/99-udisks2.rules ~/.dotFiles/rules/99-udisks2.rules;

    realrm -r ~/.dotFiles/i3Stuff;
    realcp -r ~/.i3 ~/.dotFiles/i3Stuff;

    realrm -r ~/.dotFiles/scripts;
    realcp -r ~/.scripts ~/.dotFiles/scripts;
    realcp /bin/extract ~/.dotFiles/scripts/extract;
    realcp /bin/newFolderRanger ~/.dotFiles/scripts/newFolderRanger;
    realcp /bin/newVimFile ~/.dotFiles/scripts/newVimFile;

    pacman -Qs > ~/.dotFiles/packages/packagesDescription.txt;
    pacman -Qeq > ~/.dotFiles/packages/packages.txt;

    cd ~/.dotFiles;
	git add .;
	git commit -m "(`date +%Y-%m-%d`) change dotFiles";
	git push;
	cd;
'
alias -s sh=sh
alias -s txt=vim
alias -s tex=vim
alias -s html=chromium
alias -s pdf=chromium
alias -s jpg=geeqie
alias -s jpeg=geeqie
alias -s png=geeqie
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
alias realcp='/bin/cp'
alias xclip="xclip -selection c"
alias kcc='f() { kotlinc $1 -include-runtime -d program.jar; java -jar program.jar }; f'
alias youtubemp3='f() { (mkcd MusikDownloads; youtube-dl -f m4a $1; cp ~/.convertMusic.sh .; ./.convertMusic.sh;) }; f'
alias mv='mv -iv'
alias cp='cp -iv'
alias pdflatex='f() { (pdflatex $1; trash *.aux; trash *.log; trash *.nav; trash *.out; trash *.snm; trash *.toc) }; f'
alias extract='/bin/extract'
alias newFolder='~/.scripts/newFolderRanger.sh'
alias checkInloop='sh ~/.scripts/checkInloop.sh'

clear

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nwuensche/.sdkman"
[[ -s "/home/nwuensche/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nwuensche/.sdkman/bin/sdkman-init.sh"
