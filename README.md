## Dotfiles

General config for nvim, tmux, ranger, etc.

### What do I need to install?

I primarily work on macOS but dabble in Debian; as such, all instructions (for now) are centered around [Homebrew](https://brew.sh).

All files are managed with [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html).

### How do I use this?
I've bundled *most* configuration steps under a single shell script. Simply launch `Terminal.app` and:

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

###### 3. Run the setup script
You may be prompted for your admin password, as some commands require `sudo` to successfully run. This script will ensure Homebrew is installed and working properly, set up some sensible macOS defaults, and then install all Homebrew-managed dependencies (which, at this point, should be everything you need to work).
```bash
./setup.sh
```

###### 4. Reboot your system, and partially disable System Integrity Protection (SIP)
You will need to reboot your system once the setup script completes, as some macOS settings will not take until after a system restart. Further, `yabai` requires a partial disabling of SIP in order to work properly - [instructions can be found here](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).

