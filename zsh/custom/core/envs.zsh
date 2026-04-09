# direnv
eval "$(direnv hook zsh)"

# starship
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG="$HOME"/.config/starship/starship.toml

# deno
[[ -s "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

# bun
export BUN_PATH="$HOME/.bun"
if [[ -d "$BUN_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$BUN_PATH":* ]] && export PATH="${PATH:+${PATH}:}${BUN_PATH}/bin"
    # bun completions
    [[ -s "$BUN_PATH/_bun" ]] && source "$BUN_PATH/_bun"
fi
