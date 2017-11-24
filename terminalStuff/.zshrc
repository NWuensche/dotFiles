# User configuration
export ZSH=/home/nwuensche/.oh-my-zsh

plugins=(git)
ZSH_THEME="agnoster"
EDITOR=vim
export EDITOR
ANDROID_HOME=/home/nwuensche/Android/Sdk
export ANDROID_HOME
MAVEN_OPTS="-Xmx1024m -Xms512m"
export MAVEN_OPTS
export PATH=$PATH:/home/nwuensche/Android/Sdk/tools:/home/nwuensche/Android/Sdk/platform-tools:/home/nwuensche/Android/Sdk/tools/bin

BROWSER=chromium
export BROWSER

alias saveDotFiles='
    saveStuff;

    cd ~/.dotFiles;
	git add .;
	git commit -m "(`date +%d-%m-%Y`) change dotFiles";
	git push;
	cd;
'
source $ZSH/oh-my-zsh.sh

alias -s sh=sh
alias -s txt=vim
alias -s tex=vim
alias -s html=chromium
alias -s pdf=chromium
alias -s odt=libreoffice
alias -s jpg=geeqie
alias -s jpeg=geeqie
alias -s png=geeqie
alias sudo='sudo ' # important, so that aliases work with sudo
alias mkcd='f() { mkdir $1; cd $1 }; f'
alias rm='echo "rm is disabled, use trash or realrm instead."'
alias realrm='/bin/rm'
alias realcp='/bin/cp'
alias realmv='/bin/mv'
alias xclip="xclip -selection c"
alias mv='mv -iv'
alias cp='cp -iv'
alias pdflatex='f() { (pdflatex $1; trash *.aux; trash *.log; trash *.nav; trash *.out; trash *.snm; trash *.toc) }; f'
alias downloadFolder='wget -r --no-parent'
alias z='(cd ~; vim .zshrc)'
alias v='vifm .'
alias downloadPDFsfrom='wget -r -l1 -A.pdf --no-check-certificate'
alias 2pagesPDF='pdfnup --nup 2x1 --suffix test'
