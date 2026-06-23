if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec startx
fi

# Automatically pull in standard bashrc settings for login shells (SSH/TMUX)
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Added by Antigravity CLI installer
export PATH="/home/bagoury/.local/bin:$PATH"
