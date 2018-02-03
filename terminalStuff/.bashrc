#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
zsh

# added by Anaconda3 installer
export PATH="/home/nwuensche/anaconda3/bin:$PATH"
