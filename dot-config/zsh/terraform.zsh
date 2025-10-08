# Enable TFEnv
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C "$HOMEBREW_PREFIX/Cellar/tfenv/3.0.0/versions/1.4.6/terraform terraform"

# Enable Terragrunt
complete -o nospace -C "$HOMEBREW_PREFIX/bin/terragrunt terragrunt"
