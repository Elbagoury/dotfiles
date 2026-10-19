# ~/.bashrc: load ble.sh for interactive shells only
if [[ $- == *i* ]]; then
    # st terminal sends TERM=st-256color; fall back when the server lacks its terminfo
    if [[ $TERM == st-256color ]] && ! infocmp st-256color &>/dev/null; then
        export TERM=xterm-256color
    fi

    source ~/.local/share/blesh/ble.sh

    # Basic colors: green user@host, blue path, colored ls and grep
    PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'

    # Personal aliases
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi
fi
