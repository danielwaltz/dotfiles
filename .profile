# Define operating system
os="`uname`"

# Powerline
if [[ $os == "Linux" ]]; then
	. /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
fi

# Get aliases file if it exists
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

# Get private profile file if it exists
if [ -f ~/.dotfiles/private/.profile ]; then
	source ~/.dotfiles/private/.profile
fi
