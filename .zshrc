# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

### ohmyzsh
plugins=(
  aliases
  brew
  common-aliases
  docker
  docker-compose
  fig
  git
  git-auto-fetch
  gitfast
  iterm2
  kubectl
  macos
  npm
  yarn
)
if [ -d '/Users/danielwaltz/.local/share/fig/plugins/ohmyzsh' ]; then
export ZSH="/Users/danielwaltz/.local/share/fig/plugins/ohmyzsh"
zstyle ':omz:update' mode auto
zstyle ':omz:update' mode
source '/Users/danielwaltz/.local/share/fig/plugins/ohmyzsh/oh-my-zsh.sh'
fi

### zsh-autosuggestions
if [ -d '/Users/danielwaltz/.local/share/fig/plugins/zsh-autosuggestions' ]; then
source '/Users/danielwaltz/.local/share/fig/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh'
fi

### zsh-syntax-highlighting
if [ -d '/Users/danielwaltz/.local/share/fig/plugins/zsh-syntax-highlighting' ]; then
source '/Users/danielwaltz/.local/share/fig/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
fi

### zsh-completions
if [ -d '/Users/danielwaltz/.local/share/fig/plugins/zsh-completions' ]; then
source '/Users/danielwaltz/.local/share/fig/plugins/zsh-completions/zsh-completions.plugin.zsh'
autoload -Uz compinit; compinit;
fi

### git-open
if [ -d '/Users/danielwaltz/.local/share/fig/plugins/git-open' ]; then
source '/Users/danielwaltz/.local/share/fig/plugins/git-open/git-open.plugin.zsh'
fi

### aliases
function update() {
  echo '\e[32m\uf0fc Brew'
  brew update && brew upgrade && brew upgrade --cask
  brew bundle dump --force

  echo '\e[32m\ue713 Mac'
  mas upgrade

  echo '\e[32m\uf1b2 Mise'
  mise plugins update
  mise install bun@latest && mise use -g bun@latest
  mise install deno@latest && mise use -g deno@latest
  mise install node@latest && mise use -g node@latest
  mise install python@latest && mise use -g python@latest
  mise install ruby@latest && mise use -g ruby@latest
  mise install usage@latest && mise use -g usage@latest

  echo '\e[32m\ue795 ZSH'
  omz update
}
alias -- dotfiles='$EDITOR ~/.dotfiles'
alias -- src='source ~/.zshrc'
alias -- c='clear'
alias -- spacer='defaults write com.apple.dock persistent-apps -array-add '"'"'{tile-type=\"spacer-tile\";}'"'"' && killall Dock'
alias -- spacermini='defaults write com.apple.dock persistent-apps -array-add '"'"'{tile-type=\"small-spacer-tile\";}'"'"' && killall Dock'
alias -- dsdestroy='find . -name '"'"'*.DS_Store'"'"' -type f -ls -delete'
alias -- bump='pnpx taze@latest -rwiI'

### init
export STARSHIP_CONFIG=~/.dotfiles/starship.toml
eval "$(starship init zsh)"
export EDITOR="code"
export OS="`uname`"
PATH="$PATH:""$HOME"'/.cargo/bin:'"$PATH"
eval "$(mise activate zsh)"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
