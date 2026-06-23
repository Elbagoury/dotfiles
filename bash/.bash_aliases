#!/bin/sh
for file in "$HOME/.bash_secrets" "$HOME/.bash_functions"; do
    [ -f "$file" ] && source "$file"
done
# Packages, Bash and Process Management
alias hr="history | rg" # then your word
alias r="sudo apt remove --purge"
alias ra="sudo apt autoremove"
alias u="sudo apt update"
alias uu="sudo apt update && sudo apt upgrade -y"
alias s="sudo apt search"
alias i="sudo apt install"
alias mi="sudo make clean install"
alias di="sudo dpkg -i"
alias df="sudo apt --fix-broken install"
alias cx="sudo chmod +x" # add excution to scripts
alias pk="sudo pkill -9"
alias sl="sudo ln -s" # /yourbin /usr/local/bin
alias c="clear"
alias q="exit"
alias ls="ls --color=auto -F"
alias ll="ls -lah"
alias ds="du -hx --max-depth=1 . | sort -rh | head -n 20"
alias ps="pass insert -m dotfiles/bash_secrets < ~/.bash_secrets"
alias pp="pass git pull && rm ~/.bash_secrets && pass show dotfiles/bash_secrets > ~/.bash_secrets"
alias lb="lsblk | bat -l conf"
alias mo="sudo mount /dev/sdc1 /mnt/usb"
# Source & Services Management
alias sb="source ~/.bashrc"
alias ss="sudo systemctl status" 
alias sp="sudo systemctl stop"
alias st="sudo systemctl start"
alias sr="sudo systemctl restart"
alias se="sudo systemctl enable --now"
# Hardware Management
alias hu="cd ~ && sudo umount /mnt/usb"
alias hw="sudo wpa_supplicant -i wlp0s20f3 -c /etc/wpa_supplicant/wpa_supplicant.conf"
alias hx="xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1920x1080 --pos 0x0  --output DP-2 --mode 1920x1080 --right-of HDMI-1"
alias hl="sudo ifdown wlp0s20f3; sudo pkill wpa_supplicant; sudo ifup enp0s31f6"
alias hh="sudo ifdown enp0s31f6; sudo ifup wlp0s20f3"
# Git Management
alias gu="git pull"
alias gp="git push"
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gc="git commit -m"
alias gl="git log --oneline --graph --decorate"
alias gz="lazygit"
# Cloud and Code Management
alias cl="gcloud compute instances list"
alias cp='gcloud compute ssh ${GCP_USER}@${GCP_PROD_INS}'
alias cu='gcloud compute ssh ${GCP_USER}@${GCP_UAT_INS}'
alias cs='pass show -c ${GCP_DB_PASS} && gcloud sql connect ${GCP_DB_PROD} -u ${GCP_DB_USER} -d ${GCP_DB}'
alias ct='pass show -c ${GCP_DB_PASS} && gcloud sql connect ${GCP_DB_UAT} -u ${GCP_DB_USER} -d ${GCP_DB}'
alias ci='ssh ${OI_IP}'
alias cj='ssh ${ORJ_IP}'
alias cc='code-container'
