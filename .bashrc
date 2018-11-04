#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='クリストファー \W > '

export EDITOR=nvim

if [ -f /usr/bin/screenfetch ]; then screenfetch -w; fi
