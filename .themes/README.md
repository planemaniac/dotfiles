# Personal Theme Setup

## Setup git dotfiles [reference](https://www.atlassian.com/git/tutorials/dotfiles)

```
git clone --bare git@github.com:planemaniac/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
```
NOTE: remove conflicting files if any issues

## Install [kitty](https://sw.kovidgoyal.net/kitty/index.html)
```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
```
or
```
sudo apt install kitty
```

## Install i3-gaps in [i3-gnome-flashback](https://github.com/regolith-linux/regolith-desktop/wiki/HowTo:-Use-i3-and-Gnome-without-Regolith)
```
sudo add-apt-repository ppa:kgilmer/regolith-stable
sudo apt update
sudo apt install i3-gaps-wm gnome-flashback build-essential
mkdir git && cd git
git clone https://github.com/deuill/i3-gnome-flashback
cd i3-gnome-flashback
sudo make install
```

## Install other tools
```
sudo apt install compton rofi unclutter vim htop tmux
```

## Current Theme
- [Iceberg](https://github.com/cocopon/iceberg.vim/)
- i3-gnome source: [regolith](https://github.com/regolith-linux)

### Goals
- Modular through Xresources [guide](https://www.reddit.com/r/unixporn/comments/8giij5/guide_defining_program_colors_through_xresources/)
