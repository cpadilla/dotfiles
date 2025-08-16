#!/bin/sh

# Fix screen tearing
# nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

# xrandr
# ~/.screenlayout/default.sh
~/.screenlayout/virtualmonitors.sh

xrdb ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=picom

picom &
xscreensaver --log xscreensaver.log &
xbindkeys &
while true; do
    volumeicon
done &
spotifyd
eval $(feh --bg-fill /home/chris/Desktop/background.png)

# Fix date time
# ntpd &
while true; do
    xsetroot -name "$( date +"%I:%M:%S:%2N %p %A  %F")"
    # sleep 1s
done &

# Startup apps
kdeconnectd &
kdeconnect-app &
ibus-daemon -drx &
dunst &
nm-applet &
spotify &
steam &
discord &
bitcoin-qt &
electron-mail &
pavucontrol &
obsidian &
docker-plex &
docker-emby &

# Start/restart dwm until you log out
while [ -z "$DWM_EXIT" ]; do
  dwm 2>~/.local/share/dwm.log
done
