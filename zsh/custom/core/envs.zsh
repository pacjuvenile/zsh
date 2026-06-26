# direnv
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# starship
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG="$HOME"/.config/starship/starship.toml

# bun
export BUN_PATH="$HOME/.bun"
if [[ -d "$BUN_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$BUN_PATH":* ]] && export PATH="${PATH:+${PATH}:}${BUN_PATH}/bin"
    # bun completions
    [[ -s "$BUN_PATH/_bun" ]] && source "$BUN_PATH/_bun"
fi

# agent harness
AGENT_HARNESSES=(
	codex
	claude
	pi
)
for agent_harness in "${AGENT_HARNESSES[@]}"; do
	local f="${HOME}/dotfiles/${agent_harness}/${agent_harness}-run.bash"
	[[ -f "$f" ]] && source "$f"
done
