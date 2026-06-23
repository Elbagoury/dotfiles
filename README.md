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
```
## My bin

```sh
i lazygit
mkdir ~/bin && cd bin
# install latest nvim and tree-sitter
curl -fLO https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-linux-x86_64.tar.gz
tg nvim-linux-x86_64.tar.gz
sl /home/bagoury/bin/nvim/bin/nvim /usr/local/bin/nvim
curl -fLO https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.9/tree-sitter-cli-linux-x64.zip
unzip tree-sitter-cli-linux-x64.zip
sl /home/bagoury/bin/tree-sitter /usr/local/bin/tree-sitter
```

