# 模糊查找
FZF_PATH=$(dirname "$(which fzf)")
if [[ -d "$FZF_PATH" ]]; then
    [[ ! :"$PATH": == *:"$FZF_PATH":* ]] && export PATH="${PATH:+${PATH}:}$FZF_PATH"
    source <(fzf --zsh)
fi
zinit light Aloxaf/fzf-tab
