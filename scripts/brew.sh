#!/bin/bash
#####################################################################
#      NOTE: Ensure Homebrew is properly configured and 
#      install needed packages...
#####################################################################
# Ensure that any relevant apps are closed
if which brew &> /dev/null; then
  echo "Homebrew is already installed; updating now..."
  brew update;
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew doctor;

# NOTE: install homebrew dependencies
cd ~/code/dotfiles && brew bundle install --force;

# NOTE: symlink dependencies to home directory...
stow --target=$HOME --dotfiles .

#####################################################################
#      NOTE: Set up Sketchybar, Yabai, and SKHD
#####################################################################
setup_font () {
  local dir="~/code/sb-app-font"

  if [-d "$dir/.git"]; then
    echo "Font installed; updating..."
    cd "$dir" && git pull;
  else
    mkdir -p "$dir" && git clone gh:kvndrsslr/sketchybar-app-font "$dir"
  fi

  # NOTE: build and install font to proper directory...
  cd "$dir" && pnpm install && pnpm run build:install -- "${XDG_CONFIG_HOME}/sketchybar/plugins/icon_map.sh"
}

setup_font

# NOTE: allow yabai to run sudo commands without auth...
#   docs here: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

# NOTE: enables services to start on boot and configures yabai...
brew services start sketchybar

skhd --start-service
yabai --start-service

sudo yabai --load-sa


#####################################################################
#      NOTE: Launch synology drive client so we can
#       pull down preferences...
#####################################################################
for app in "1Password" \
  "Synology Drive Client" do
  osascript -e "tell application \"$app\" to launch"
done

echo "Done installing packages...finish your config!"

