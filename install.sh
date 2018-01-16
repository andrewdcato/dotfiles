#!/bin/sh

echo "Setting up your Mac..."

if test ! $(which brew)
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Do all the Homebrew installations
brew update

# Install Tmuxinator
gem install tmuxinator
