# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# =====================================================================
# 1. INITIALIZE BASH LINE EDITOR (Must be at the very top)
# =====================================================================
if [[ $- == *i* ]]; then
    source ~/.local/share/blesh/ble.sh
fi

# =====================================================================
# 2. CORE UTILITIES & ENVIRONMENT VARIABLES
# =====================================================================
export FZF_DEFAULT_OPTS="--color=bg+:#3c3836,bg:#282828,spinner:#8ec07c,hl:#98971a,fg:#ebdbb2,header:#928374,info:#b16286,pointer:#8ec07c,marker:#98971a,fg+:#ebdbb2,prompt:#b16286,hl+:#b8bb26 --layout=reverse --border"

# Initialize Zoxide (Smarter cd)
eval "$(zoxide init bash)"

# Handy workflow aliases
alias bat="batcat"
alias preview="fzf --preview 'batcat --color=always --style=numbers {}'"
alias rgf="rg --files | fzf"

# =====================================================================
# 3. FZF INTEGRATION (The official ble.sh safe way)
# =====================================================================
if [[ $- == *i* ]]; then
    if [[ ${BLE_VERSION-} ]]; then
        # If ble.sh is running, load its internal optimized fzf modules
        ble-import -d integration/fzf-completion
        ble-import -d integration/fzf-key-bindings
    else
        # Fallback for standard bash environments without ble.sh
        if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
            source /usr/share/doc/fzf/examples/key-bindings.bash
        fi
    fi
fi

# =====================================================================
# 4. CUSTOM MINIMALIST PROMPT & GIT BRANCH (Must be at the bottom)
# =====================================================================
_git_prompt() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " ($branch)"
}
export PS1="\[\033[1;34m\]\w\[\033[1;31m\]\$(_git_prompt)\[\033[1;32m\] > \[\033[0m\]"
# SSH Config
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # Prepend a distinct Cyan colored (hostname) to your existing prompt layout
    PS1="\[\e[1;36m\](\h)\[\e[0m\] $PS1"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/bagoury/bin/google-cloud-sdk/path.bash.inc' ]; then . '/home/bagoury/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/bagoury/bin/google-cloud-sdk/completion.bash.inc' ]; then . '/home/bagoury/bin/google-cloud-sdk/completion.bash.inc'; fi

# Pi
export PATH="/home/bagoury/.local/share/pi-node/node-v22.22.3-linux-x64/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/home/bagoury/.local/bin:$PATH"
export PATH="/home/bagoury/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
