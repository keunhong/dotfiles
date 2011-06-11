#!/bin/sh
# Custom startup script for Xmonad

# set cursor
xsetroot -cursor_name left_ptr


# Remap capslock to control
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'

# Turn on volume manager
#gnome-session&
#thunar --daemon&
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1&

# Start compositor
#cairo-compmgr&

# Turn on flux
#xflux -z 61801

# Set background
#feh --bg-scale ~/Images/wallpaper.jpg

#gnome-terminal&

killall trayer
~/bin/trayer.sh
#gnome-panel&
#mpd
#xfce4-panel&
