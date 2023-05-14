source "$DOT_DIR/aliases.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(sheldon source)"
eval "$(starship init zsh)"
