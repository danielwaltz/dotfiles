# Dotfiles

These are my personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Installation

1. Install [homebrew](https://brew.sh/)
    - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
1. Install and configure [zsh](https://www.zsh.org/)
    - `brew install zsh`
    - `echo $(which zsh) | sudo tee -a /etc/shells`
    - `chsh -s $(which zsh)`
1. Install and initialize [chezmoi](https://www.chezmoi.io/)
    - `brew install chezmoi`
    - `chezmoi init --apply danielwaltz`
