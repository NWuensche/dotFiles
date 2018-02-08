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
#export PATH="/home/nwuensche/anaconda3/bin:$PATH"
export PATH=$PATH:/home/nwuensche/Android/Sdk/tools:/home/nwuensche/Android/Sdk/platform-tools:~/Downloads/phantomjs-2.1.1-linux-x86_64/bin

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
alias -s jpg=feh
alias -s jpeg=feh
alias -s png=feh
alias cal='ncal -M -b'
alias calc=gcalccmd
alias sudo='sudo ' # important, so that aliases work with sudo
alias mkcd='f() { mkdir $1; cd $1 }; f'
alias rm='echo "rm is disabled, use trash or realrm instead."'
alias realrm='/bin/rm'
alias realcp='/bin/cp'
alias realmv='/bin/mv'
alias scanIPs='sudo arp-scan --interface=wlp4s0 --localnet'
alias xclip="xclip -selection c"
#alias cisco="/opt/cisco/anyconnect/bin/vpnui"
alias mv='mv -iv'
alias cp='cp -iv'
alias pdflatex='f() { (pdflatex $1; trash *.aux; trash *.log; trash *.nav; trash *.out; trash *.snm; trash *.toc) }; f'
alias downloadFolder='wget -r --no-parent'
alias z='(cd ~; vim .zshrc)'
alias v='vifm .'
alias downloadPDFsfrom='wget -r -l1 -A.pdf --no-check-certificate'
alias 2pagesPDF='pdfnup --nup 2x1 --suffix test'
alias reducePDF='f() { gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS="/printer" -sOutputFile=output.pdf $1  }; f'
alias FEp='f() {mplayer $(wget https://rss.simplecast.com/podcasts/1684/rss -O- 2>/dev/null| grep "enclosure" | tac | sed -n $1p | cut -f2 -d"\"")}; f'
alias sendKindle='f() {echo "" | for doc do mutt -s "test" "$(cat ~/saveFolder/kindleAddress.txt)" -a "$doc"; done}; f'
