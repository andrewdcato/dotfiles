# Set a few defaults to our shell.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
export DEFAULT_USER="andrewcato"
export EDITOR="nvim"
export PYENV_ROOT="$HOME/.pyenv"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export ANS_DIR="$HOME/surety/ansible"

# Setup Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use PyEnv instead of system python
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/opt/homebrew/opt/mongodb-community@4.4/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="$HOME/.config/sesh/scripts:$PATH"

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

# Auto-add keys to ssh-agent
if [ $(ps ax | grep "[s]sh-agent" | wc -l) -eq 0 ] ; then
    eval $(ssh-agent -s) > /dev/null
    if [ "$(ssh-add -l)" = "The agent has no identities." ] ; then
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519 > /dev/null 2>&1
        ssh-add --apple-use-keychain ~/.ssh/servers_rsa > /dev/null 2>&1
        ssh-add --apple-use-keychain ~/.ssh/personal > /dev/null 2>&1
    fi
fi

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

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

# Configure Bat as manpager
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# Configure terragrunt
complete -o nospace -C /opt/homebrew/bin/terragrunt terragrunt
