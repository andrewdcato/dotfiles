# Path to your oh-my-zsh installation.
export ZSH=/Users/andrewcato/.oh-my-zsh
# Set default user account for themes that recognize this
export DEFAULT_USER="andrewcato"
export PAGER="most"
export EDITOR='vim'

# Load tmuxinator
source ~/.bin/tmuxinator.zsh

#Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lambda/lambda-mod"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. This makes repository status check # for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow zsh-syntax-highlighting sublime nvm rvm rake brew vagrant)
source $ZSH/oh-my-zsh.sh

# User configuration

# Add NVM and RVM
source ~/.nvm/nvm.sh
export PATH="$PATH:$HOME/.rvm/bin"


source "/Users/andrewcato/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
