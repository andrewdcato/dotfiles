## Dotfiles

General config for macOS and the core tools I use:

* [neovim](https://github.com/neovim/neovim)
* [tmux](https://github.com/tmux/tmux)
* [Ghostty](https://github.com/ghostty-org/ghostty)
* [Yabai](https://github.com/koekeishiya/yabai)
* [SKHD](https://github.com/koekeishiya/skhd)

All files in this repo are managed with [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html).

### How do I use this?
First, you'll need to ensure that System Integrity Protection is at least partially disabled so that `yabai` will work properly - [instructions can be found here](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).

Once that's done, fire up `Terminal.app` for (hopefully) the last time and follow the steps below.

###### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

###### 2. Install git and clone the repo

```bash
brew install git

mkdir -p ~/code

git clone https://github.com/andrewdcato/dotfiles ~/code/dotfiles && cd ~/code/dotfiles
```

###### 3. Run the macOS script
You may be prompted for your admin password, as some commands require `sudo` to successfully run. This script will set macOS preferences, hide the Dock and Menubar,  and then trigger a reboot.
```bash
./scripts/macos.sh
```

###### 4. Run the deps script
This script will ensure that Homebrew is installed and working, configure core dependencies, invoke `stow` to symlink dotfiles, and then fire up `yabai`, `skhd`, and `sketchybar`.
```bash
./scripts/deps.sh
```

