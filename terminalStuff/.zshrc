# Path to your oh-my-zsh installation.
#export ZSH=/home/nwuensche/.oh-my-zsh
#ZSH_THEME="agnoster"
#plugins=(git)
#source $ZSH/oh-my-zsh.sh

# User configuration
EDITOR=vim
export EDITOR
ANDROID_HOME=/home/nwuensche/Android/Sdk
export ANDROID_HOME
MAVEN_OPTS="-Xmx1024m -Xms512m"
export MAVEN_OPTS

BROWSER=chromium
export BROWSER

alias saveDotFiles='

    realcp ~/.gitconfig ~/.dotFiles/gitStuff/.gitconfig;

	realcp ~/.vimrc ~/.dotFiles/vimStuff/.vimrc;
    realcp -r ~/.vim/snippets ~/.dotFiles/vimStuff;
    realcp ~/.vim/bundle/vim-autoswap/plugin/autoswap.vim ~/.dotFiles/vimStuff/autoswap.vim

    realcp ~/.xinitrc ~/.dotFiles/XStuff/.xinitrc;
	realcp ~/.bashrc ~/.dotFiles/terminalStuff/.bashrc;
	realcp ~/.zshrc ~/.dotFiles/terminalStuff/.zshrc;
	realcp ~/.zprofile ~/.dotFiles/terminalStuff/.zprofile;
    realcp -r ~/.oh-my-zsh/themes/agnoster.zsh-theme ~/.dotFiles/terminalStuff/agnoster.zsh-theme;
    realcp ~/.thunderbird/mnle6z31.default/user.js ~/.dotFiles/XStuff/user.js;

    realcp ~/.config/terminator/config ~/.dotFiles/configs/config.terminator;
    realcp ~/.config/vifm/vifmrc ~/.dotFiles/configs/vifmrc;
    realcp ~/.i3/config ~/.dotFiles/configs/config.i3;

    realcp /etc/udev/rules.d/99-udisks2.rules ~/.dotFiles/rules/99-udisks2.rules;

    realcp /etc/systemd/system/rfkill-own.service ~/.dotFiles/services/;

    realcp /bin/youtubemp3 ~/.dotFiles/scripts/youtubemp3;
    realcp /bin/1SekVideos ~/.dotFiles/scripts/1SekVideos;
    realcp /bin/extract ~/.dotFiles/scripts/extract;
    crontab -l > ~/.dotFiles/scripts/crontab

    pacman -Qs > ~/.dotFiles/packages/packagesDescription.txt;
    pacman -Qeq > ~/.dotFiles/packages/packages.txt;

    saveStuff;

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
alias -s odt=libreoffice
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
alias mkcd='f() { mkdir $1; cd $1 }; f'
alias getIt='f() { source ~/.dontDelete $1 }; f'
alias rm='echo "rm is disabled, use trash or realrm instead."'
alias realrm='/run/current-system/sw/bin/rm'
alias realcp='/run/current-system/sw/bin/cp'
alias xclip="xclip -selection c"
alias kcc='f() { kotlinc $1 -include-runtime -d program.jar; java -jar program.jar }; f'
alias mv='mv -iv'
alias cp='cp -iv'
alias pdflatex='f() { (pdflatex $1; trash *.aux; trash *.log; trash *.nav; trash *.out; trash *.snm; trash *.toc) }; f'
alias extract='/bin/extract'
alias downloadFolder='wget -r --no-parent'
alias createLink='ln -s'
alias z='(cd ~; vim .zshrc)'
alias p='pacman -Syua'
alias s='sudoedit /etc/hosts'
alias v='vifm .'
alias downloadPDFsfrom='wget -r -l1 -A.pdf --no-check-certificate'
alias 2pagesPDF='pdfnup --nup 2x1 --suffix test'
alias realmv='/run/current-system/sw/bin/mv'


#clear

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nwuensche/.sdkman"
[[ -s "/home/nwuensche/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nwuensche/.sdkman/bin/sdkman-init.sh"
