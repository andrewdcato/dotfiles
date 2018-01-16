#!/bin/sh
echo "Setting up your Mac..."

if test ! $(which brew)
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Do all the Homebrew installations
brew update

# Install Node Carbon
nvm install 8

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Spaceship
curl -o - https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/install.zsh | zsh

# Install Tmuxinator
gem install tmuxinator

# Symlink all the things!
echo "Symlinking zshrc..."
rm ~/.zshrc
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
source ~/.zshrc

echo "Symlinking vimrc"
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
source ~/.vimrc

echo "Symlinking Tmux"
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
source ~/.tmux.conf

echo "Symlinking Tmuxinator..."
ln -s ~/.dotfiles/tmuxinator/ ~/.tmuxinator
ln -s ~/.dotfiles/tmuxinator/mux.zsh ~/.bin/tmuxinator.zsh

echo "That's all, folks!"
