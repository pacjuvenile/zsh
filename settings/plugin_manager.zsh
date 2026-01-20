# 插件管理器
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
[[ -s "${ZINIT_HOME}/zinit.zsh" ]] && source "${ZINIT_HOME}/zinit.zsh"

# 基础插件
ZVM_INIT_MODE=sourcing
ZVM_LAZY_KEYBINDINGS=false
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# 扩展插件
PLUGIN_CONFIG_HOME="${HOME}/dotfiles/zsh/plugins"
for plugin_config_file in "${PLUGIN_CONFIG_HOME}"/**/*.zsh; do
  [[ -s "$plugin_config_file" ]] && source "$plugin_config_file"
done
