# fzf配置
FZF_PATH=$(dirname "$(which fzf)")
if [[ -d "$FZF_PATH" ]]; then
    [[ ! :"$PATH": == *:"$FZF_PATH":* ]] && export PATH="${PATH:+${PATH}:}$FZF_PATH"
    source <(fzf --zsh)
fi
# 更改映射
bindkey '^t' fzf-file-widget
bindkey '^r' fzf-history-widget
bindkey -r '\ec'
# 启用插件
zinit light Aloxaf/fzf-tab
