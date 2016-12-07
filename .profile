# Define operating system
os="`uname`"

# Get aliases file if it exists
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
