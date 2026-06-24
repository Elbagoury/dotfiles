## My Dotfiles
## Install Essential Tools
```sh
apt install sudo git
```

### Install and config fonts
```sh
i fontconfig unzip fonts-noto-core fonts-noto-ui-core fonts-noto-color-emoji
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMonoNerd
fc-cache -fv 
stow fonts
# Verify the Installation
fc-list : family | grep -i "jetbrains" | uniq
```
## My APT Tools 
```sh
# Network, Sound and Browser
i wpasupplicant wireless-tools firefox-esr mpv alsa-utils pipewire-audio wireplumber pulsemixer pulseaudio-utils
# My TUI,  add fzf and zoxide conf to .bashrc
i tmux fzf ripgrep zoxide bat lazygit

```
## My local bin 

```sh
mkdir ~/bin && cd bin
# install latest nvim and tree-sitter
curl -fLO https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-linux-x86_64.tar.gz
tx nvim-linux-x86_64.tar.gz
ln /home/bagoury/bin/nvim/bin/nvim /usr/local/bin/nvim
curl -fLO https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.9/tree-sitter-cli-linux-x64.zip
unzip tree-sitter-cli-linux-x64.zip
ln /home/bagoury/bin/tree-sitter /usr/local/bin/tree-sitter
# Install yazi TUI file manager 
curl -fLO https://github.com/sxyazi/yazi/releases/download/v26.5.6/yazi-x86_64-unknown-linux-gnu.deb
di yazi-x86_64-unknown-linux-gnu.deb
# if there is missing dependencies `sudo apt --fix-broken install` 
# install ble.sh for bash autocomplete
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local # the config are in ~/.bashrc
rm -rf ble.sh
# Get GAM 7
curl -fLO  https://github.com/GAM-team/GAM/releases/download/v7.46.02/gam-7.46.02-linux-x86_64-glibc2.39.tar.xz
tx gam-7.. ; ln / /
curl -fLO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xf google-cloud-cli-linux-x86_64.tar.gz
rm google-cloud-cli-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
```
## Sound and Network Configration
`systemctl --user enable --now pipewire pipewire-pulse wireplumber`
Add to MPV: ` echo "ao=pipewire" >> ~/.config/mpv/mpv.conf` Test: `mpv /mnt/usb/linux.mp4`
Run `ip addr` to see cards
Search for Wifi: `sudo iwlist wlp0s20f3 scan | grep ESSID`
Save it: `sudo nvim /etc/network/interfaces`
```text
allow-hotplug wlp0s20f3
iface wlp0s20f3 inet dhcp
        wpa-ssid mywif
        wpa-psk  password
```
For Troubleshooting: `wpa_passphrase "Mywifi" "pass" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf`
`pk wpa_supplicant ; pk dhcpcd ; sudo ifdown wlp0s20f3 ; hw ; sudo dhcpcd wlp0s20f3`


## Install latest Docker
```sh
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update
```
```sh
i docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker bagoury
sudo systemctl status docker
sudo systemctl start docker
sudo docker run hello-world
# install devcontainers
i nodejs npm
sudo npm install -g @devcontainers/cli
cd ~/prj/tac12
devcontainer open .
```
