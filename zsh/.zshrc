# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=/Users/andrewcato/.oh-my-zsh

# Ensure proper color scheme is used
export TERM=screen-256color

# Set default user account for themes that recognize this
export DEFAULT_USER="andrewcato"
export PAGER="most"
export EDITOR='vim'

# Hack for running mongodb@3.4 as 'mongo'
export PATH="/usr/local/opt/mongodb@4.0/bin:$PATH"

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# This *has* to be the last thing added to path or it'll break
export PATH="$PATH:$HOME/.rvm/bin"

# Load Custom things
source ~/.bin/tmuxinator.zsh
source ~/.nvm/nvm.sh
source "/Users/andrewcato/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# OMZ customization
ZSH_THEME="spaceship"
ZSH_TMUX_AUTOSTART_ONCE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  ansible
  brew
  git
  git-flow
  nvm
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# You have to load this *after* declaring plugins or it won't work...odd
source $ZSH/oh-my-zsh.sh

# Theme Customizations
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  terraform
  exec_time     # Execution time
  time          # Time stamps
  battery
  line_sep      # Line break
  char          # Prompt character
)

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_12HR=true
SPACESHIP_NODE_DEFAULT_VERSION='v8.9.4'
SPACESHIP_BATTERY_SHOW=true
SPACESHIP_BATTERY_THRESHOLD=50
SPACESHIP_EXIT_CODE_SHOW=true

# Custom Aliases
alias bump="./bump.sh"
alias vim="nvim"
alias gpt="git push && git push --tags"
alias gfpub="git flow feature publish $(git branch | sed -n '/\* feature\//s///p')"
alias szshrc="source ~/.zshrc"
alias zshrc="vim ~/.dotfiles/zsh/.zshrc"
alias gitClean="git branch --merged | egrep -v \"(^\*|master|develop|production)\" | xargs git branch -d"

# Adds & commits
function ac(){
  git add .
  git commit -m "$1"
}

# Add, commit, & push
function acp(){
  git add .
  git commit -m "$1"
  git push
}

# Changes to SB Static directory, runs compiler, and notifies when done
function buildPreview(){
  cd ~/surety/surety-bonds-static
  vagrant up
  vagrant ssh -c "cd /vagrant; rake generatePreview; exit"
  osascript -e 'display notification "Site preview compiled at 10.2.2.2!" with title "Compilation Complete!"'
}

function buildSite(){
  cd ~/surety/surety-bonds-static
  vagrant up
  vagrant ssh -c "cd /vagrant; rake generate_site; exit"
  osascript -e 'display notification "Full site compiled at 10.2.2.2!" with title "Compilation Complete!"'
}

# Kill all docker containers with "none" tags
#alias dkill="docker rmi $(docker images | grep '^<none>' | awk '{print $3}')"

# Link Ngrok executable
alias ngrok="~/.dotfiles/ngrok"

# Ngrok shortcuts
alias nlms='ngrok http -subdomain=sb1-lms 3000'
alias nconnect='ngrok http -subdomain=sb1-connect 5000'
alias nem='ngrok http -subdomain=sb1-ews 5500'
alias nams='ngrok http -subdomain=sb1-ams 5001'

# Ansible Aliases
export ANS_DIR="/Users/andrewcato/surety/ansible"
export PROD_INV="$ANS_DIR/inventory/production"
export STAG_INV="$ANS_DIR/inventory/staging"

# Takes an arg to limit bounces via hostname
function bounce(){
  ansible-playbook -K -i $ANS_DIR/inventory --limit="$1" $ANS_DIR/bounceApps.yml
}

alias pingAll="ansible-playbook -K -i $PROD_INV -i $STAG_INV $ANS_DIR/ping.yml"

# Force NVM to load the specified version of Node
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
