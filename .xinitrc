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

# Set up the god damned (first?) second monitor
xrandr --output HDMI1 --auto --right-of DVI-D-0
xrandr --newmode "1920x1080_60.00"  148.50  1920 2008 2052 2200  1080 1084 1089 1125 -hsync +vsync
xrandr --addmode HDMI1 1920x1080_60.00
xrandr --output HDMI1 --mode 1920x1080_60.00

# turn off the stupid virtual monitors (why did I even buy them)
xrandr --output DP-1 --off
xrandr --output DP-3 --off
xrandr --output DP-5 --off

# Fix screen tearing
# nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

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

# Start keybinder
xbindkeys &

# Statusbar loop
while true; do
	# xsetroot -name "$( date +"%F  |  %r")"
	dwmstatus
	# sleep 1s  # Update time every minute
done &

# Syncronize clipboards
# autocutsel -fork  &
# autocutsel -selection PRIMARY -fork  &

# Startup programs
slack &
discord &
spotify &

# Start dwm
while true; do
	# Log stderror to a file
	dwm 2> ~/.logs/.dwm.log
done

# export GDK_BACKEND=x11

# exec gnome-session

