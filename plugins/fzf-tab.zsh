# 模糊查找
# zinit light Aloxaf/fzf-tab
FZF_PATH=$(dirname "$(which fzf)")
if [[ -d "$FZF_PATH" ]]; then
    [[ ! :"$PATH": == *:"$FZF_PATH":* ]] && export PATH="${PATH:+${PATH}:}$FZF_PATH"
    source <(fzf --zsh)
fi
