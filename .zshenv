# Add local binaries to the PATH
LOCAL_BIN="$HOME/.local/bin"
if ! [[ ":$PATH:" == *:"$LOCAL_BIN":* ]]; then
  export PATH="$LOCAL_BIN:$PATH"
fi

# Configure PyEnv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Configure Node Version Manager ENV
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Configure Rust
source "$HOME/.cargo/env"

# Configure SDKMAN
source "$HOME/.sdkman/bin/sdkman-init.sh"