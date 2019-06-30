#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Fix screen tearing
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

# set the background
feh --bg-fill ~/Desktop/background.jpg &

# ====================
# fonts and languages
# ====================
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
#uim-xim &
ibus-daemon -drx
export XMODIFIERS=@im=ibus
# ====================

# make fonts available
xset fp+ /usr/share/fonts/Twitter\ Color\ Emoji

# Start xcompmgr
xcompmgr &

# Startup programs
# fish start_jack.fish &
dunst &
riot-desktop &
discord &
spotify &
cool-retro-term -e /mnt/x/Documents/GitHub/MusicBot/run.sh &

# Start keybinder
xbindkeys &

# Start jack audio
# jack_control start
# jack_control ds alsa
# jack_control dps device hw:Audio
# jack_control dps rate 48000
# jack_control dps nperiods 2
# jack_control dps period 64
# sleep 10
# a2jmidid -e &
pulseaudio --start &

# Statusbar loop
while true; do
	# xsetroot -name "$( date +"%F  |  %r")"
	dwmstatus
	sleep 1s  # Update time every minute
done &

# Set up screen layout
xrandr --output DVI-D-0 --auto --output HDMI1 --auto --left-of DVI-D-0

# Start dwm
while true; do
	# Log stderror to a file
	dwm 2> ~/.logs/.dwm.log
done

# export GDK_BACKEND=x11

# exec gnome-session

