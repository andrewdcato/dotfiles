# Set a few defaults to our shell.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
export DEFAULT_USER="andrewcato"
export EDITOR="nvim"
export PYENV_ROOT="$HOME/.pyenv"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export ANS_DIR="$HOME/surety/ansible"

# Config flags for tmux session manager
export T_SESSION_USE_GIT_ROOT="true"
export T_SESSION_NAME_INCLUDE_PARENT="true"

# Setup Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load Ghostty integration
# if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
#   "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
# fi

# Use PyEnv instead of system python
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/opt/homebrew/opt/mongodb-community@4.4/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="${PATH}:${HOME}/.local/bin/"

export PATH="$XDG_CONFIG_HOME/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH"

# Set theme for FZF
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=rounded \
"

# OMZ customization
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

export CORRECT_IGNORE_FILE='.zsh_correctignore'
setopt correct
setopt histignorealldups
setopt histreduceblanks

# OMZ TMUX CONFIG
# TODO: get .config dir working for TMUX w/ZSH_TMUX_CONFIG

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  ansible
  brew
  git
  git-flow
  nvm
  terraform
)

# You have to load this *after* declaring plugins or it won't work...odd
source $ZSH/oh-my-zsh.sh

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Apply the proper rice
source $ZSH/custom/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh

# Load homebrew-managed extensions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Configure tfenv
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/Cellar/tfenv/3.0.0/versions/1.4.6/terraform terraform

# pnpm
export PNPM_HOME="/Users/andrewcato/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Load custom aliases
source "$HOME/.zsh_aliases"

# Configure terragrunt
complete -o nospace -C /opt/homebrew/bin/terragrunt terragrunt
