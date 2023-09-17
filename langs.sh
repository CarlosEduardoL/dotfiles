#!/usr/bin/env bash

# This function installs NodeJS using Node Version Manager
install_nodejs() {
  # Check if node command is available
  if ! cmd node; then
    echo "Installing NodeJS"
    # Download and install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    # Set NVM directory and source it
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    # Install the latest LTS version of NodeJS using NVM
    nvm install --lts
  fi
}

# This function installs Python using PyEnv
install_python() {
  # Check if pyenv command is available
  if ! cmd pyenv; then
    # Clone PyEnv repository to home directory
    git clone 'https://github.com/pyenv/pyenv.git' "$HOME/.pyenv"
    # Set PyEnv root directory and add it to PATH
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    # Initialize PyEnv
    eval "$(pyenv init -)"
    # Install the latest Python 3.11 version using PyEnv and set it as global version
    pyenv install 3.11:latest
    pyenv global "$(pyenv latest 3.11)"
  fi
}

# This function installs Rust using rustup
install_rust() {
  # Check if cargo command is available
  if ! cmd cargo; then
    # Download rustup script to a temporary file
    RUST_UP="/tmp/rustup.sh"
    curl --proto '=https' --tlsv1.2 -sSf -o "$RUST_UP" https://sh.rustup.rs
    # Make the script executable and run it with -y option to proceed with installation without prompting for confirmation
    chmod u+x "$RUST_UP"
    "$RUST_UP" -y
    # Source the cargo environment script which was installed by rustup script to update PATH for accessing newly installed commands
    source "$HOME/.cargo/env"
    # Install cargo-binstall using a script from its repository
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  fi
}

# This function installs Java, Kotlin, and Groovy using SDKMAN!
install_java_kotlin_groovy() {
  # Check if SDKMAN! is installed by checking its initialization script existence
  if [[ ! -f "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    # Download and install SDKMAN!
    curl -s "https://get.sdkman.io" | bash
    # Source the SDKMAN! initialization script to update PATH for accessing newly installed commands
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    # Install Java, Kotlin, and Groovy using SDKMAN!
    sdk install java
    sdk install kotlin
    sdk install groovy
  fi
}

# Flag for installing all languages
all_langs=false

# Parse command line options
while getopts ":a" opt; do
  case $opt in
  a) all_langs=true ;; # If -a option is provided, set all_langs flag to true
  \?) ;;
  esac
done

# If all_langs flag is true, call all installation functions
if $all_langs; then
  install_nodejs
  install_python
  install_rust
  install_java_kotlin_groovy

# If all_langs flag is false, prompt user for which languages to install
else
  echo "Which languages do you want to install?"
  echo "1) NodeJS"
  echo "2) Python"
  echo "3) Rust"
  echo "4) Java/Kotlin/Groovy"
  echo "Enter the numbers separated by space (e.g. '1 2' to install NodeJS and Python): "

  read -ra langs

  for lang in "${langs[@]}"; do

    # Call corresponding installation function based on user input
    case $lang in
    1) install_nodejs ;;
    2) install_python ;;
    3) install_rust ;;
    4) install_java_kotlin_groovy ;;
    *) echo "Invalid option: $lang" ;; # Print error message for invalid input
    esac

  done

fi
