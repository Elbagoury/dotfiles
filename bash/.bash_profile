if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec startx
fi

# Automatically pull in standard bashrc settings for login shells (SSH/TMUX)
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

