# fzf配置
FZF_PATH=$(dirname "$(which fzf)")
if [[ -d "$FZF_PATH" ]]; then
    [[ ! :"$PATH": == *:"$FZF_PATH":* ]] && export PATH="${PATH:+${PATH}:}$FZF_PATH"
    source <(fzf --zsh)
fi
# 更改映射
bindkey -r '^T'
bindkey '\et' fzf-file-widget
bindkey -r '^R'
bindkey '\er' fzf-history-widget
# 启用插件
zinit light Aloxaf/fzf-tab
