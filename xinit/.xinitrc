# Import environment variables into the systemd user session
dbus-update-activation-environment --all &
# Switch Esc with caps , Add AR
setxkbmap -option -option caps:escape -option altwin:menu_win &
setxkbmap -layout us,ara -option grp:win_space_toggle &
# Notification daemon
dunst &
# Battery notification daemon
~/ref/auto/battery-notify.sh &
# Status bar and window manager
slstatus &
exec dwm
