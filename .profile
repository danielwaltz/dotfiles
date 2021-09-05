EDITOR="code"
OS="`uname`"

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

[ -f ~/.dotfiles/private/.profile ] && source ~/.dotfiles/private/.profile
