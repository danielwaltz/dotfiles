# Dotfiles

These are my personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Installation

1. Install [homebrew](https://brew.sh/) and initial packages:
    - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
    - `brew install chezmoi zsh`
1. Configure [zsh](https://www.zsh.org/) and set default shell:
    - `echo $(which zsh) | sudo tee -a /etc/shells`
    - `chsh -s $(which zsh)`
1. Initialize [chezmoi](https://www.chezmoi.io/):
    - `chezmoi init --apply danielwaltz`
