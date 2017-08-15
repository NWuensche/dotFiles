#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc
export SHELL=/bin/zsh
exec /bin/zsh -l

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nwuensche/.sdkman"
[[ -s "/home/nwuensche/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nwuensche/.sdkman/bin/sdkman-init.sh"
