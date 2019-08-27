# Get main shared profile
[ -f ~/.profile ] && source ~/.profile

export ZSH=~/.oh-my-zsh

# THEMES
# gitster
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme

# PLUGINS
# git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
# brew install zsh-autosuggestions zsh-syntax-highlighting

ZSH_THEME="gitster"

if [[ $OS == "Darwin" ]]; then
	plugins=(common-aliases git git-auto-fetch yarn npm vscode docker docker-compose zsh-nvm osx brew)
fi

if [[ $OS == "Linux" ]]; then
	plugins=(common-aliases git git-auto-fetch yarn npm vscode docker docker-compose zsh-nvm systemd)
fi

export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ruby env manager
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
