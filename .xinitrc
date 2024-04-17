#!/bin/sh

# Fix screen tearing
# nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

xrdb ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

picom &
xscreensaver &
while true; do
    volumeicon
done &
spotifyd
eval $(feh --bg-fill /home/chris/Desktop/background.png)

# Fix date time
# ntpd &
while true; do
    xsetroot -name "$( date +"%T:%2N %A  %F")"
    # sleep 1s
done &


# exec /home/chris/Downloads/dwm-6.4/dwm
exec dwm
