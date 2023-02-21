[ -f ~/.profile ] && source ~/.profile
[ -f ~/.aliases ] && source ~/.aliases

export ZSH=~/.oh-my-zsh

ZSH_THEME="gitster"
DISABLE_UPDATE_PROMPT=true
UPDATE_ZSH_DAYS=7

# PLUGINS
# brew install zsh-autosuggestions zsh-syntax-highlighting

if [[ $OS == "Darwin" ]]; then
  plugins=(
    brew
    macos

    asdf
    common-aliases
    docker
    docker-compose
    doctl
    git
    git-auto-fetch
    gitfast
    kubectl
    npm
    rust
    vscode
    yarn
  )

  source $(brew --prefix)/etc/profile.d/z.sh
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ $OS == "Linux" ]]; then
  plugins=(
    systemd

    asdf
    common-aliases
    docker
    docker-compose
    doctl
    git
    git-auto-fetch
    gitfast
    kubectl
    npm
    rust
    vscode
    yarn
  )
  source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

source $ZSH/oh-my-zsh.sh

export STARSHIP_CONFIG=~/.dotfiles/starship.toml
eval "$(starship init zsh)"
