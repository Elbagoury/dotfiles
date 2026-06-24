# Import environment variables into the systemd user session
dbus-update-activation-environment --all &
setxkbmap -option -option caps:escape -option altwin:menu_win &
slstatus &
exec dwm
