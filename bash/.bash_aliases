#!/bin/sh
for file in "$HOME/.bash_secrets" "$HOME/.bash_functions"; do
    [ -f "$file" ] && source "$file"
done
# Single: A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
alias b="cat ~/.bash_aliases | rg" # then your word
alias c="clear"
alias i="sudo apt install"
alias s="sudo apt search"
alias r="sudo apt remove --purge"
alias h="history | rg" # then your word
alias u="sudo apt update"
alias q="exit"
# A,B,C,D,E,F: apt,dpkg,du,docker, code, chmod,ffmpeg
alias af="sudo apt --fix-broken install"
alias au="sudo apt update && sudo apt upgrade -y"
alias aa="sudo apt autoremove"
alias cc='code-container'
alias cx="sudo chmod +x" # add excution to scripts
alias di="sudo dpkg -i"
alias ds="du -hx --max-depth=1 . | sort -rh | head -n 20"
alias dbc='docker exec -i tac12_devcontainer-db-1 psql -U odoo -d postgres -c "CREATE DATABASE odoo_prod;"'
alias dbr='pv ~/dow/odoo-db.sql | docker exec -i tac12_devcontainer-db-1 psql -U odoo -d odoo_prod'
alias fr='screen-record'
# G,H,I,J,K,L: git, gcloud, gpg, gam,ifdown, ifup,ifconfig, ln, ls, lsblk, lib, lazygit
alias gu="git pull"
alias gp="git push"
alias gs="git status"
alias ga="git add "
alias gd="git diff"
alias gc="git commit -m"
alias gl="git log --oneline --graph --decorate"
alias ggn='git config --global user.name "Mohamed Elbagoury"' # Use 3 or 4 letters alias if it used one time
alias ggm='git config --global user.email ${HOTMAIL}'
alias gpep='gpg --export -a ${HOTMAIL} > ~/dow/public.key'
alias gpes='gpg --export-secret-keys -a ${HOTMAIL} > ~/dow/private.key'
alias gpeo='gpg --export-ownertrust > ~/dow/otrust.txt'
alias gpip='gpg --import ~/dow/public.key'
alias gpis='gpg --import ~/dow/private.key'
alias gpio='gpg --import-ownertrust ~/dow/otrust.txt'
alias gpk='gpg --list-secret-keys --keyid-format LONG'
alias gm='gam user ${TACMAIL} check serviceaccount'
alias gmm='gam user ${TACMAIL} show messages query' # then your search: "odoo after:2026/01/01"
alias gcl="gcloud compute instances list"
alias gcp='gcloud compute ssh ${GCP_USER}@${GCP_PROD_INS}'
alias gcu='gcloud compute ssh ${GCP_USER}@${GCP_UAT_INS}'
alias gsp='pass show -c ${GCP_DB_PASS} && gcloud sql connect ${GCP_DB_PROD} -u ${GCP_DB_USER} -d ${GCP_DB}'
alias gsu='pass show -c ${GCP_DB_PASS} && gcloud sql connect ${GCP_DB_UAT} -u ${GCP_DB_USER} -d ${GCP_DB}'
alias gspp='cloud-sql-proxy ${GCP_PROJ}:${GCP_REGION}:${GCP_DB_PROD} --port 5433'  # use it wih pgcli
alias gspu='cloud-sql-proxy ${GCP_PROJ}:${GCP_REGION}:${GCP_DB_UAT} --port 5434'
alias il="sudo ifdown wlp0s20f3; sudo pkill wpa_supplicant; sudo ifup enp0s31f6"
alias iw="sudo ifdown enp0s31f6; sudo ifup wlp0s20f3"
alias ln="sudo ln -s" # /yourbin /usr/local/bin
alias ls="eza --icons"
alias ll="ls -lah"
alias lb="lsblk | bat -l conf"
alias lc="/lib/x86_64-linux-gnu/libc.so.6" # Chceck glibc version
alias lg="lazygit"
# M,N,O,P,Q,R: make, mount,nmcli, pass, pkill, pgcli, ps_mem
alias mi="sudo make clean install"
alias mm="sudo mount /dev/sdc1 /mnt/usb"
alias mu="cd ~ && sudo umount /mnt/usb"
alias nd="nmcli device" # check devices `sd wpa_supplicant` first
alias nw="nmcli device wifi list"
alias nwc="nmcli device wifi connect" # "wifi" password "pass"
alias pf="pass insert -m" # dotfiles/myfile < ~/.file"
alias pe="pass edit" # dotfiles/myfile
alias ps="pass show" # dotfiles/bash_secrets > ~/.bash_secrets"
alias pc="pass show -c "
alias pr="pass rm"
alias pk="sudo pkill -9"
alias pgp='pass show -c ${GCP_DB_PASS} && pgcli -h 127.0.0.1 -p 5433 -U ${GCP_DB_USER} -d ${GCP_DB}'
alias pgu='pass show -c ${GCP_DB_PASS} && pgcli -h 127.0.0.1 -p 5434 -U ${GCP_DB_USER} -d ${GCP_DB}'
alias pgl='pgcli -h 127.0.0.1 -p 5432 -U odoo -d odoo_prod'
alias pm='sudo ps_mem'
# S,T,U,V,W,X,Y,Z : ssh, source, systemctl, tar, wpa_supplicant, xrandr
alias sb="source ~/.bashrc"
alias ss="sudo systemctl status" 
alias sp="sudo systemctl stop"
alias st="sudo systemctl start"
alias sr="sudo systemctl restart"
alias sd="sudo systemctl disable"
alias se="sudo systemctl enable --now"
alias so='ssh ${OI_IP}'
alias sj='ssh ${ORJ_IP}'
alias tx="tar -xf"
alias tf="tar -tf" # file then | head -n 5 to check the content of the file
alias ww="sudo wpa_supplicant -i wlp0s20f3 -c /etc/wpa_supplicant/wpa_supplicant.conf"
alias xc="xrandr | rg connected"
alias xd="xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 1920x1080 --pos 0x0  --output DP-2 --mode 1920x1080 --right-of HDMI-1"
alias xm="xrandr --output eDP-1 --auto --primary --output HDMI-1 --off --output DP-1 --off"
