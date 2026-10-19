# ~/.bashrc: load ble.sh for interactive shells only
if [[ $- == *i* ]]; then
    source ~/.local/share/blesh/ble.sh

    # Basic colors: green user@host, blue path, colored ls and grep
    PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi
