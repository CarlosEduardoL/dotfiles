#!/usr/bin/env bash

# Install NodeJS Stable using Node Version Manager
install_nodejs() {
  if ! cmd node; then
    echo "Installing NodeJS"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    nvm install --lts
  fi
}

# Use PyEnv over python System version to keep stability (Arch nightmares)
install_python() {
  if ! cmd pyenv; then
    git clone 'https://github.com/pyenv/pyenv.git' "$HOME/.pyenv"
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    pyenv install 3.11:latest
    pyenv global "$(pyenv latest 3.11)"
  fi
}

# Install Rust using rustup 
install_rust() {
  if ! cmd cargo; then
    RUST_UP="/tmp/rustup.sh"
    curl --proto '=https' --tlsv1.2 -sSf -o "$RUST_UP" https://sh.rustup.rs
    chmod u+x "$RUST_UP"
    "$RUST_UP" -y
    source "$HOME/.cargo/env"
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  fi
}

# Install Java/Kotlin/Groovy using SDK man
install_java_kotlin_groovy() {
  if [[ ! -f "$HOME/.sdkman/bin/sdkman-init.sh" ]] ; then
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk install java
    sdk install kotlin
    sdk install groovy
  fi
}

all_langs=false

while getopts ":a" opt; do
  case $opt in 
    a) all_langs=true ;;
    \?);;
  esac 
done 

if $all_langs; then 
  install_nodejs
  install_python
  install_rust
  install_java_kotlin_groovy
else 
  echo "Which languages do you want to install?"
  echo "1) NodeJS"
  echo "2) Python"
  echo "3) Rust"
  echo "4) Java/Kotlin/Groovy"
  echo "Enter the numbers separated by space (e.g. '1 2' to install NodeJS and Python): "
  
  read -ra langs
  
  for lang in "${langs[@]}"; do
    case $lang in 
      1) install_nodejs ;;
      2) install_python ;;
      3) install_rust ;;
      4) install_java_kotlin_groovy ;;
      *) echo "Invalid option: $lang" ;;
    esac 
  done 
fi