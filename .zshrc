export HISTFILE=~/.zsh_history
export HISTSIZE=100000

[[ -f "$DOT_DIR/custom_config.zsh"]] && source "$DOT_DIR/custom_config.zsh"

source "$DOT_DIR/aliases.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(sheldon source)"
eval "$(starship init zsh)"
