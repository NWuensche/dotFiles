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
export PATH=$PATH:/home/nwuensche/Android/Sdk/tools:/home/nwuensche/Android/Sdk/platform-tools:~/Downloads/phantomjs-2.1.1-linux-x86_64/bin:~/.nix-profile/bin:~/.local/bin

#No Files found in gitignore in fzf vim
export FZF_DEFAULT_COMMAND='fd --type f'   
export tm='{"isarrival": false,"limit": 30,"mentzonly": false,"mot": ["Tram","CityBus","IntercityBus",        "SuburbanRailway",        "Train",        "Cableway",        "Ferry",        "HailedSharedTaxi"],    "shorttermchanges": true,    "stopid": "33000658",    "time": "2018-02-20T19:54:00.000Z"}'

export BROWSER="chromium-browser"

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
alias -s pdf=evince
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
alias mutt='imapfilter && mutt'
alias cp='cp -iv'
alias pdflatex='f() { (pdflatex $1; trash *.aux; trash *.log; trash *.nav; trash *.out; trash *.snm; trash *.toc) }; f'
alias downloadFolder='wget -r --no-parent'
alias z='(cd ~; vim .zshrc)'
alias v='vifm .'
alias downloadPDFsfrom='wget -r -l1 -A.pdf --no-check-certificate'
alias 2pagesPDF='pdfnup --nup 2x1 --suffix test'
alias reducePDF='f() { gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS="/printer" -sOutputFile=output.pdf $1  }; f'
alias FEp='f() {mplayer $(wget https://rss.simplecast.com/podcasts/1684/rss -O- 2>/dev/null| grep "enclosure" | tac | sed -n $1p | cut -f2 -d"\"")}; f'
alias sendKindle='f() {echo "" | for doc do mutt -s "test" -e "$(cat ~/saveFolder/sendKindleFrom.txt)" "$(cat ~/saveFolder/kindleAddress.txt)" -a "$doc"; done}; f'
alias histrm='f() { LC_ALL=C sed --in-place "/$1/d" $HISTFILE;};f'
alias getIt='f() {getIt $1; histrm get;clear; zsh}; f'
alias mountAndroid='sudo mkdir -p /mnt/Android; sudo jmtpfs /mnt/Android; sudo vifm /mnt/Android'
alias search='googler --count 3'
alias youtube='mpsyt'
alias trash-restore='restore-trash'
alias t='tmux attach'
alias clong='curl -X POST -d $tm https://webapi.vvo-online.de/dm\?format\=json --header "Content-Type:application/json"'
alias readSite='f() {python3 ~/.dotFiles/scripts/read.py $1 | w3m -T 'text/html'}; f'
alias vimBA="vim -c 'startinsert' -c 'set tw=70 et' -c 'set wrap' '+/^$'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
