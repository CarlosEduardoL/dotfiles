#!/usr/bin/env bash

LOCAL_BIN="$HOME/.local/bin"

install_exa() {
  # Install Exa (ls replacement powered by rust)
  if ! cmd exa; then
    cargo binstall -y exa
  fi
}

install_bat() {
  # Install bat (cat replacement powered by rust)
  if ! cmd bat; then
    cargo binstall -y bat
  fi
}

install_marktext() {
  # Install MarkText (My favorite markdown editor)
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Do you want to install MarkText? (y/n)"
    read proceed

    if [[ $proceed == "y" ]]; then
      if ! cmd marktext; then
        curl -L -o "$LOCAL_BIN/marktext" 'https://github.com/marktext/marktext/releases/download/v0.17.1/marktext-x86_64.AppImage'
        chmod u+x "$LOCAL_BIN/marktext"
      fi
    else
      echo "Skipping installation of MarkText."
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Do you want to install MarkText using Homebrew? (y/n)"
    read proceed

    if [[ $proceed == "y" ]]; then
      if ! cmd marktext; then
        brew install --cask mark-text
      fi
    else
      echo "Skipping installation of MarkText."
    fi
  else
    echo "MarkText is only available on Linux and macOS. Skipping installation."
  fi
}

install_neovim() {
  # Install neovim stable from github releases or using Homebrew on macOS
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Do you want to install Neovim? (y/n)"
    read proceed

    if [[ $proceed == "y" ]]; then
      if ! cmd nvim; then
        echo "Installing Neovim"
        curl -L -o "$LOCAL_BIN/nvim" 'https://github.com/neovim/neovim/releases/download/stable/nvim.appimage'
        chmod u+x "$LOCAL_BIN/nvim"
      fi
    else
      echo "Skipping installation of Neovim."
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Do you want to install Neovim using Homebrew? (y/n)"
    read proceed

    if [[ $proceed == "y" ]]; then
      if ! cmd nvim; then
        brew install neovim
      fi
    else 
      echo "Skipping installation of Neovim."
    fi 
  else 
    echo "Neovim is only available on Linux and macOS. Skipping installation."
  fi 
}

install_lunarvim() {
  # Install lunar vim, I just like it
  if ! cmd lvim; then
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
  fi
}

install_tldr() {
  # Install tldr
  if ! cmd tldr; then
    npm install -g tldr
  fi
}

install_jetbrains_nerd_font() {
  # Install a NerdFont. I just choose Jetbrains since I like it 
  FONTS_FOLDER="$HOME/.local/share/fonts"
  mkdir -p "$FONTS_FOLDER"
  if ! test -n "$(find "$FONTS_FOLDER" -iname '*Jetbrains*nerd*' -print -quit)";then
    FONT="/tmp/font.zip"
    curl -L -o "$FONT" 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/JetBrainsMono.zip'
    unzip "$FONT" -d "$FONTS_FOLDER"
  fi
}

# Check if Rust is installed before attempting to use cargo to install Exa and bat 
if cmd cargo; then 
  install_exa 
  install_bat 
else 
  echo "Rust is not installed. Do you want to install Rust and proceed with installing Exa and bat? (y/n)"
  
  read proceed
  
  if [[ $proceed == "y" ]]; then 
    install_rust
    
    install_exa 
    install_bat 
  else 
    echo "Skipping installation of Exa and bat."
  fi 
fi 

# Check if NodeJS is installed before attempting to use npm to install tldr 
if cmd npm; then 
  install_tldr 
else 
  echo "NodeJS is not installed. Do you want to install NodeJS and proceed with installing tldr? (y/n)"
  
  read proceed
  
  if [[ $proceed == "y" ]]; then 
    install_nodejs
    
    install_tldr 
  else 
    echo "Skipping installation of tldr."
  fi 
fi 

install_neovim

# Check if all required languages are installed before attempting to install LunarVim
missing_langs=()

if ! cmd node; then 
  missing_langs+=("NodeJS")
fi

if ! cmd pyenv; then 
  missing_langs+=("Python")
fi

if ! cmd cargo; then 
  missing_langs+=("Rust")
fi

if [[ ${#missing_langs[@]} -gt 0 ]]; then 
  echo "The following languages are required to install LunarVim but are not currently installed: ${missing_langs[*]}"
  echo "Do you want to install the missing languages and proceed with installing LunarVim? (y/n)"
  
  read proceed
  
  if [[ $proceed == "y" ]]; then 
    for lang in "${missing_langs[@]}"; do 
      case $lang in 
        "NodeJS") install_nodejs ;;
        "Python") install_python ;;
        "Rust") install_rust ;;
      esac 
    done 
    
    install_lunarvim
  else 
    echo "Skipping installation of LunarVim."
  fi 
else 
  install_lunarvim
fi

# Call the functions to install the remaining tools
install_marktext
install_jetbrains_nerd_font