export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000000
export SAVEHIST=100000000

if [ -f "$DOT_DIR/custom_config.zsh" ]; then
  source "$DOT_DIR/custom_config.zsh"
fi

if [ -f "$DOT_DIR/aliases.zsh" ]; then
  source "$DOT_DIR/aliases.zsh"
fi

if [ -f "$DOT_DIR/functions.zsh" ]; then
  source "$DOT_DIR/functions.zsh"
fi

if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
fi
