# Define operating system
os="`uname`"

# Get aliases file if it exists
if [ -f ~/.aliases ]; then
	source ~/.aliases
fi

# Get private profile file if it exists
if [ -f ~/.dotfiles/private/.profile ]; then
	source ~/.dotfiles/private/.profile
fi
