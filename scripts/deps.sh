#!/bin/bash
#####################################################################
#      NOTE: Ensure Homebrew is properly configured and 
#      install needed packages...
#####################################################################
# Ensure that any relevant apps are closed
if command -v brew  &> /dev/null; then
  echo "Homebrew is already installed; updating now..."
  brew update;
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew doctor

# install homebrew dependencies
cd "$HOME/code/dotfiles" && brew bundle install --force;

#####################################################################
#      NOTE: Set up Tmux, NVM, etc.
#####################################################################
# agree to xcode license
sudo xcodebuild -license accept

# Install NVM - script is smart enough to check for updates if already installed...
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh)"

setup_tmux () {
  local dir="$HOME/.tmux/plugins/tpm"

  if [ -d "$dir/.git" ]; then
    echo "TPM installed; updating..."
    cd "$dir" && git pull;
  else
    mkdir -p "$dir" && git clone gh:tmux-plugins/tpm "$dir"
  fi

  cd "$HOME/code/dotfiles"
}

setup_tmux;
stow --target=$HOME --dotfiles "$HOME/code/dotfiles/."
bat cache --build

#####################################################################
#      NOTE: Set up Sketchybar, Yabai, and SKHD
#####################################################################
setup_font () {
  local dir="$HOME/code/sb-app-font"

  if [ -d "$dir/.git" ]; then
    echo "Font installed; updating..."
    cd "$dir" && git pull;
  else
    mkdir -p "$dir" && git clone gh:kvndrsslr/sketchybar-app-font "$dir"
  fi

  # NOTE: build and install font to proper directory...
  cd "$dir" && pnpm install && pnpm run build:install "$XDG_CONFIG_HOME/sketchybar/plugins/icon_map.sh"
}

setup_font

# NOTE: enables services to start on boot and configures yabai...
brew services start sketchybar

#####################################################################
#      NOTE: Launch synology drive client so we can
#       pull down preferences...
#####################################################################
for app in "1Password" \
  "Synology Drive Client"; do
  osascript -e "tell application \"$app\" to launch"
done

echo "Done installing packages...finish your config!"

