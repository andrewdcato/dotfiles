# Configure 1pCLI plugins & autocompletions
source "$HOME/.config/op/plugins.sh"
eval "$(op completion zsh)"; compdef _op op

# Export env vars that are needed by system
export LOANSPARK_AI_KEY="$(op read 'op://Loanspark/API Gateway/api key')"

