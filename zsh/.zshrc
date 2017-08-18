# Path to your oh-my-zsh installation.
export ZSH=/Users/andrewcato/.oh-my-zsh
# Set default user account for themes that recognize this
export DEFAULT_USER="andrewcato"
export PAGER="most"
export EDITOR='vim'
# This *has* to be the last thing added to path or it'll break
export PATH="$PATH:$HOME/.rvm/bin"

# Load Custom things
source ~/.bin/tmuxinator.zsh
source ~/.nvm/nvm.sh
source "/Users/andrewcato/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# OMZ customization
ZSH_THEME="spaceship"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow zsh-syntax-highlighting sublime nvm rvm rake brew vagrant)
# You have to load this *after* declaring plugins or it won't work...odd
source $ZSH/oh-my-zsh.sh

# Theme Customizations
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  #package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  golang        # Go section
  docker        # Docker section
  exec_time     # Execution time
  time          # Time stamps
  line_sep      # Line break
  char          # Prompt character
)

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_12HR="true"
SPACESHIP_RUBY_SYMBOL="💎  "

# Custom Aliases
alias bump="./bump.sh"
alias gpt="git push && git push --tags"
alias szshrc="source ~/.zshrc"
alias zshrc="vim ~/.dotfiles/zsh/.zshrc"
# Kill all docker containers with "none" tags
alias dkill="docker rmi $(docker images | grep '^<none>' | awk '{print $3}')"
