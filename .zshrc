# Get main shared profile
[ -f ~/.profile ] && source ~/.profile

export ZSH=~/.oh-my-zsh

ZSH_THEME="gitster"

# PLUGINS
# brew install zsh-autosuggestions zsh-syntax-highlighting

if [[ $OS == "Darwin" ]]; then
  plugins=(asdf common-aliases docker docker-compose doctl git gitfast git-auto-fetch kubectl npm vscode yarn osx brew)
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ $OS == "Linux" ]]; then
  plugins=(asdf common-aliases docker docker-compose doctl git gitfast git-auto-fetch kubectl npm vscode yarn systemd)
  source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

DISABLE_UPDATE_PROMPT=true
UPDATE_ZSH_DAYS=7

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/sbin:$PATH"
export PATH="$(yarn global bin):$PATH"
export ANDROID_HOME=/Users/daniel.waltz/Library/Android/sdk
export ANDROID_SDK=/Users/daniel.waltz/Library/Android/sdk
export PATH=/Users/daniel.waltz/Library/Android/sdk/platform-tools:$PATH
export PATH=/Users/daniel.waltz/Library/Android/sdk/emulator:$PATH

export STARSHIP_CONFIG=~/.dotfiles/starship.toml
eval "$(starship init zsh)"
