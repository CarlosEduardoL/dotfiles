export HISTFILE=~/.zsh_history
export HISTSIZE=100000

if [ -f "$DOT_DIR/custom_config.zsh" ]; then 
  source "$DOT_DIR/custom_config.zsh"
fi

source "$DOT_DIR/aliases.zsh"

if [ -f "$HOME/.fzf.zsh" ]; then 
  source "$HOME/.fzf.zsh"
fi

eval "$(sheldon source)"
eval "$(starship init zsh)"
