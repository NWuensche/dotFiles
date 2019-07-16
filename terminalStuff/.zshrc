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
export PATH=$PATH:/home/nwuensche/Android/Sdk/tools:/home/nwuensche/Android/Sdk/platform-tools:~/.nix-profile/bin:~/.local/bin:~/.cabal/bin:~/saveFolder/privateScripts:~/.dotFiles/scripts:/home/nwuensche/.gem/ruby/2.6.0/bin

export MESA_GLSL_CACHE_DISABLE=true #Fix Bug Chrome

#No Files found in gitignore in fzf vim
export FZF_DEFAULT_COMMAND='fd --type f'   

export BROWSER="chromium-browser"

alias gf='/usr/bin/gf'
alias feh='feh --auto-rotate'
alias screenshotXVFB="DISPLAY=:19 import -window root /tmp/screenshot.png; feh /tmp/screenshot.png"
alias android-file-transfer="aft-mtp-cli"
alias git='hub'
source $ZSH/oh-my-zsh.sh

alias -s sh=sh
alias -s txt=vim
alias -s tex=vim
alias -s md=vim
alias -s html=chromium
alias -s pdf=zathura
alias -s odt=libreoffice
alias -s jpg=feh
alias -s jpeg=feh
alias -s png=feh
alias calc="bc -l"
alias sudo='sudo ' # important, so that aliases work with sudo
alias mpv='cat '
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
alias scan='scanimage --format=png > ~/scan.png; echo "scan can be found in ~/scan.png"'
alias reducePDFMore='f() { gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS="/screen" -sOutputFile=output.pdf $1  }; f'
alias reducePDFMore2='f() { gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS="/ebook" -sOutputFile=output.pdf $1  }; f'
alias FEp='f() {mplayer $(wget https://rss.simplecast.com/podcasts/1684/rss -O- 2>/dev/null| grep "enclosure" | tac | sed -n $1p | cut -f2 -d"\"")}; f'
alias sendKindle='f() {echo "" | for doc do neomutt -s "test" -e "$(cat ~/saveFolder/sendKindleFrom.txt)" "$(cat ~/saveFolder/kindleAddress.txt)" -a "$doc"; done}; f'
alias histrm='f() { LC_ALL=C sed --in-place "/$1/d" $HISTFILE;};f'
alias getIt='f() {getIt $1; histrm get;clear; zsh}; f'
alias search='googler --count 3'
alias youtube='mpsyt'
alias convertALLEPUBS='for EPUBBOOK in *.epub; do; ebook-convert $EPUBBOOK "${EPUBBOOK%.*}.mobi"; done'
#alias trash-restore='restore-trash'
alias t='tmux attach || tmux new'
alias readSite='f() {python3 ~/.dotFiles/scripts/read.py $1 | w3m -T 'text/html'}; f'
alias recover='f() {sudo grep -a -B100 -A100 "$0" /dev/sda3 > recover.txt; echo "recover can be found in ~/recover.txt"}; f'
alias decompileJAR='f() {java -cp "/opt/IntelliJ/plugins/java-decompiler/lib/java-decompiler.jar" org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler $0}; f'
alias vimBA="vim -c 'startinsert' -c 'set tw=70 et' -c 'set wrap' '+/^$'"
alias x2="xrandr --output DP2 --auto --output HDMI1 --auto --right-of DP2 --output eDP1 --off"
alias x1="xrandr --output eDP1 --auto --output HDMI1 --off --output DP2 --off"
#alias calcurse="/usr/local/bin/calcurse"
alias pacman="yay"

#VNS Stuff
alias ctest="(cd /home/nwuensche/Dokumente/6.Semester/VNS/Vanda; cabal configure --enable-tests && cabal test)"
alias fixAndroid="sudo  ~/Android/Sdk/platform-tools/adb kill-server; sudo  ~/Android/Sdk/platform-tools/adb start-server"
alias cbuild="(cd /home/nwuensche/Dokumente/6.Semester/VNS/Vanda; cabal build)"
alias sv="source /opt/anaconda/bin/activate root; conda activate py368"

#Android Stuff
alias aShell="Xvfb :20 -screen 0 1024x768x16 &;export DISPLAY=:20;~/Android/Sdk/emulator/emulator @Nexus_4_API_28 &; sleep 5; adb shell"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/nwuensche/.sdkman"
#[[ -s "/home/nwuensche/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nwuensche/.sdkman/bin/sdkman-init.sh"
