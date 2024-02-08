## Dotfiles

General config for nvim, tmux, ranger, etc.

### What do I need to install?

I primarily work on macOS but dabble in Debian; as such, all instructions (for now) are centered around [Homebrew](https://brew.sh).

###### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

###### 2. Install git

```bash
brew install git
```

###### 3. Install GNU stow

```bash
brew install stow
```

###### 4. Link everything

```bash
cd ~/.dotfiles; stow .
```

Once that's done, you can install all other system dependencies by running `brew bundle install`
