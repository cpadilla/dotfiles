#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#!/bin/sh
if [ "$TERM" = "xterm-256color" ]; then
      /bin/echo -e "
                \e]P0fcef0a
                \e]P16ffffb
                \e]P2fcef0a
                \e]P33366cc
                \e]P4b967ff
                \e]P505ffa1
                \e]P600eeff
                \e]P71c4c9c
                \e]P80066ff
                \e]P99999ff
                \e]PA00ccff
                \e]PBd3323d
                \e]PC0099cc
                \e]PD0099ff
                \e]PE00ffff
                \e]PF4c4c4c
                "
    # get rid of artifacts
    clear
fi

# Launch fish
if [ -t 1 ]; then
    exec fish
fi

alias ls='ls --color=auto'
PS1='クリストファー \W > '

export EDITOR=nvim

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

if [ -f /usr/bin/screenfetch ]; then screenfetch -w; fi
