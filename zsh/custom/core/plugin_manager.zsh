# 插件管理器
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
[[ -s "${ZINIT_HOME}/zinit.zsh" ]] && source "${ZINIT_HOME}/zinit.zsh"

# 加载插件
PLUGIN_CONFIG="${ZSH_CONFIG}/custom/plugins"
[[ -s "$PLUGIN_CONFIG"/zsh-vi-mode.zsh ]] && source "$PLUGIN_CONFIG"/zsh-vi-mode.zsh
for plugin_config_file in "${PLUGIN_CONFIG}"/**/*.zsh(N.); do
  if [[ "$plugin_config_file" != "$PLUGIN_CONFIG"/zsh-vi-mode.zsh ]]; then
    [[ -s "$plugin_config_file" ]] && source "$plugin_config_file"
  fi
done
