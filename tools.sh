#!/usr/bin/env bash

LOCAL_BIN="$HOME/.local/bin"

# Install binstall
cargo install --locked cargo-binstall &>/dev/null

# Install Exa (ls replacement powered by rust)
if ! cmd exa; then
  cargo binstall -y exa
fi

# Install bat (cat replacement powered by rust)
if ! cmd bat; then
  cargo binstall -y bat
fi

# Install MarkText (My favorite markdown edito)
if ! cmd marktext; then
  curl -L -o "$LOCAL_BIN/marktext" 'https://github.com/marktext/marktext/releases/download/v0.17.1/marktext-x86_64.AppImage'
  chmod u+x "$LOCAL_BIN/marktext"
fi

# Install neovim stable from github releases
if ! cmd nvim; then
  echo "Installing Neovim"
  curl -L -o "$LOCAL_BIN/nvim" 'https://github.com/neovim/neovim/releases/download/stable/nvim.appimage'
  chmod u+x "$LOCAL_BIN/nvim"
fi

# Install lunar vim, I just like it
if ! cmd lvim; then
  LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
fi

# Toolbox to install Jetbrains IDEs
if ! cmd jetbrains-toolbox; then
  curl -L -o "/tmp/jetbrains-toolbox.tar.gz" 'https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.28.1.15219.tar.gz?_gl=1*1tl1a3w*_ga*MjEzNzkzNjY4My4xNjg0MzU0NjE4*_ga_9J976DJZ68*MTY4NDM1NDYxNy4xLjEuMTY4NDM1NDY1Ni4wLjAuMA..'
  mkdir -p /tmp/toolbox
  tar xvzf "/tmp/jetbrains-toolbox.tar.gz" -C /tmp/toolbox
  find /tmp/toolbox -type f | xargs -I{} mv {} "$HOME/.local/bin/jetbrains-toolbox"
  chmod u+x "$HOME/.local/bin/jetbrains-toolbox"
fi

# Install tldr
if ! cmd tldr; then
  npm install -g tldr
fi

# Install a NerdFont. I just choose Jetbrains since I like it 
FONTS_FOLDER="$HOME/.local/share/fonts"
mkdir -p "$FONTS_FOLDER"
if ! test -n "$(find "$FONTS_FOLDER" -iname '*Jetbrains*nerd*' -print -quit)";then
  FONT="/tmp/font.zip"
  curl -L -o "$FONT" 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/JetBrainsMono.zip'
  unzip "$FONT" -d "$FONTS_FOLDER"
fi

