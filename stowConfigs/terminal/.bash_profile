#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc
export SHELL=/bin/zsh
exec /bin/zsh -l

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nwuensche/.sdkman"
[[ -s "/home/nwuensche/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nwuensche/.sdkman/bin/sdkman-init.sh"
export PATH=~/pebble-dev/pebble-sdk-4.5-linux64/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/nwuensche/.lmstudio/bin"
# End of LM Studio CLI section

source "$HOME/.cargo/env"
