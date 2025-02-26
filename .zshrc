# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

### ohmyzsh
plugins=(
  aliases
  brew
  bun
  common-aliases
  deno
  docker
  docker-compose
  git
  git-auto-fetch
  gitfast
  iterm2
  kubectl
  macos
  mise
  npm
  ssh
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

  echo '\e[32m\ue711 Mac'
  mas upgrade

  echo '\e[32m\uf1b2 Mise'
  mise plugins update
  mise install bun@latest && mise use -g bun@latest
  mise install deno@latest && mise use -g deno@latest
  mise install node@latest && mise use -g node@latest
  mise install ruby@latest && mise use -g ruby@latest

  echo '\e[32m\ue7a8 Rust'
  rustup update

  echo '\e[32m\ue795 Zsh'
  omz update
}
alias -- dotfiles='$EDITOR ~/.dotfiles'
alias -- src='source ~/.zshrc'
alias -- c='clear'
alias -- spacer='defaults write com.apple.dock persistent-apps -array-add '"'"'{tile-type=\"spacer-tile\";}'"'"' && killall Dock'
alias -- spacermini='defaults write com.apple.dock persistent-apps -array-add '"'"'{tile-type=\"small-spacer-tile\";}'"'"' && killall Dock'
alias -- dsdestroy='find . -name '"'"'*.DS_Store'"'"' -type f -ls -delete'
alias -- bump='bunx taze@latest -rwiI'
alias -- bumpall='bunx taze@latest major -rwiu && git commit -am "chore: update deps"'
alias -- rmlock='rm -rf **/node_modules(N) **/package-lock.json(N) **/yarn.lock(N) **/pnpm-lock.yaml(N) **/bun.lock(N) **/bun.lockb(N) **/deno.lock(N)'
alias -- rmdist='rm -rf **/dist(N) **/.output(N) **/build(N) **/out(N)'
alias -- lint='bunx oxlint@latest --tsconfig tsconfig.json --import-plugin --jsdoc-plugin --vitest-plugin --react-perf-plugin --promise-plugin --node-plugin'

### init
export STARSHIP_CONFIG=~/.dotfiles/starship.toml
eval "$(starship init zsh)"
export EDITOR="code"
export OS="`uname`"
export GPG_TTY=$(tty)
PATH="$PATH:""$HOME"'/.cargo/bin:'"$PATH"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
