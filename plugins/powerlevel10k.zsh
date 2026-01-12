# 启用 Powerlevel10k 的即时提示功能
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# 运行`p10k configure`或直接编辑 ~/.p10k.zsh以自定义提示符
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
