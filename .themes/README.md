# Personal Theme Setup

## Setup git dotfiles [reference](https://www.atlassian.com/git/tutorials/dotfiles)

- Clone dotfile from repo
`git clone --bare git@github.com:planemaniac/dotfiles.git $HOME/.cfg`

- Define alias in current scope
`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

- Checkout dotfiles
`config checkout`

NOTE: remove conflicting files if any issues
