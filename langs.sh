#!/usr/bin/env bash

# Install NodeJS Stable using Node Version Manager
if ! cmd node; then
  echo "Installing NodeJS"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  nvm install --lts
fi

# Use PyEnv over python System version to keep stability (Arch nightmares)
if ! cmd pyenv; then
  git clone 'https://github.com/pyenv/pyenv.git' "$HOME/.pyenv"
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  pyenv install 3.11:latest
  pyenv global "$(pyenv latest 3.11)"
fi

# Install Rust using rustup 
if ! cmd cargo; then
  RUST_UP="/tmp/rustup.sh"
  curl --proto '=https' --tlsv1.2 -sSf -o "$RUST_UP" https://sh.rustup.rs
  chmod u+x "$RUST_UP"
  "$RUST_UP" -y
  source "$HOME/.cargo/env"
  cargo install cargo-binstall
fi

# Install Java/Kotlin/Groovy using SDK man
if [[ ! -f "$HOME/.sdkman/bin/sdkman-init.sh" ]] ; then
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install java
  sdk install kotlin
  sdk install groovy
fi
