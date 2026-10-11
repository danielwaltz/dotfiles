_dotfiles_load_syntax_highlighting() {
  add-zsh-hook -d precmd _dotfiles_load_syntax_highlighting
  source "$(antidote path zsh-users/zsh-syntax-highlighting)/zsh-syntax-highlighting.zsh"
  unfunction _dotfiles_load_syntax_highlighting
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _dotfiles_load_syntax_highlighting
