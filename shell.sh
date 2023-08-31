#!/usr/bin/env bash

# I'll generate config files only for ZSH, so it's required
if ! cmd zsh; then
  echo >&2 "Please install zsh before continue"
  exit 1
fi

if ! cmd chsh; then
  echo >&2 "chsh is required, please install it"
  exit 1
fi

if [[ ! "$(cat /etc/passwd | grep $USER | awk -F: '{print $NF}')" == */zsh ]]; then
  echo "Changin the Default shell to ZSH"
  chsh -s $(which zsh)
fi

if cmd cargo; then 
  # Install Starship prompt
  if ! cmd starship; then
    cargo binstall -y starship
    cp "$DOT_DIR/starship.toml" "$HOME/.config/"
  fi

  # Install Sheldon plugin manager
  if ! cmd sheldon; then
    cargo binstall -y sheldon
    mkdir -p "$HOME/.config/sheldon"
    cp "$DOT_DIR/plugins.toml" "$HOME/.config/sheldon"
  fi
fi

# Install fzf
if ! cmd fzf; then
  git clone --depth 1 'https://github.com/junegunn/fzf.git' "$HOME/.fzf"
  "$HOME/.fzf/install" --no-fish --no-bash --key-bindings --completion 
fi

# Update plugins if new plugins added on update
if [[ "$DOT_DIR/plugins.toml" -nt "$HOME/.config/sheldon/plugins.toml" ]]; then
  cp "$DOT_DIR/plugins.toml" "$HOME/.config/sheldon"
fi

# Configure zshenv
ZSHENV="$HOME/.zshenv"
if [[ -f "$ZSHENV" ]] && ! cmp -s "$ZSHENV" "$DOT_DIR/.zshenv" ; then
  mv "$ZSHENV" "$HOME/.zshenv_bak" && echo "your zsh env has being backuped on .zshenv_bak"
fi
cp "$DOT_DIR/.zshenv" "$ZSHENV" 

# Configure zshrc
ZSHRC="$HOME/.zshrc"
if [[ -f "$ZSHRC" ]] && ! cmp -s "$ZSHRC" <(cat <(echo "DOT_DIR='$DOT_DIR'") <(cat "$DOT_DIR/.zshrc")); then
  mv "$ZSHRC" "$HOME/.zshrc_bak" && echo "your zsh config has being backuped on .zshrc_bak"
fi
cat <(cat "$DOT_DIR/.zshrc" | head -n 3) <(echo "DOT_DIR='$DOT_DIR'") <(cat "$DOT_DIR/.zshrc" | grep -v "$(cat "$DOT_DIR/.zshrc" | head -n 3)") > "$ZSHRC"

if cmd starship; then
  echo 'eval "$(sheldon source)"
eval "$(starship init zsh)"' >> "$ZSHRC"
fi

echo "In the case you want any custon aliases, functions or everithing else please use custom_config.zsh file"