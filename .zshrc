######################
# 启用提示符美化
######################
# 启用 Powerlevel10k 的即时提示功能
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# 运行`p10k configure`或直接编辑 ~/.p10k.zsh以自定义提示符
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

######################
# 设置插件管理器
######################
# 设置$ZINIT_HOME
ZINIT_HOME=$HOME/.local/share/zinit/zinit.git
# 安装zinit
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# 激活zinit
[[ -s "$ZINIT_HOME"/zinit.zsh ]] && source "$ZINIT_HOME/zinit.zsh"
# 初始化补全系统
autoload -Uz compinit && compinit
# 注册 Zinit 补全
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

######################
# zsh插件管理
######################
# 主题美化
zinit ice depth"1"  # git clone depth
zinit light romkatv/powerlevel10k

# 高亮、补全和提示
zinit light zsh-users/zsh-syntax-highlighting 
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# 模糊查找
zinit light Aloxaf/fzf-tab
# fzf配置
FZF_PATH="$HOME/.fzf/bin"
if [[ -d "$FZF_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$FZF_PATH":* ]] && export PATH="${PATH:+${PATH}:}$FZF_PATH"
    source <(fzf --zsh)
fi
#将 Tab 绑定为补全（覆盖默认切换行为）
# 1. 禁用默认 Tab 切换分组/候选的行为
zstyle ':fzf-tab:*' switch-group ''
# 2. 配置 fzf-tab 弹窗按键：Tab/Enter 均为确认补全
zstyle ':fzf-tab:*' fzf-bindings \
  'tab:accept' \          # Tab 键直接补全选中项
export FZF_CTRL_T_COMMAND="fdfind \"\" /home/sunny/ /mnt/c/Users/sunny/Desktop/ /mnt/c/Users/sunny/AppData/Roaming/ /mnt/c/Users/sunny/.config/ -I -i -t f -t d -t l --hidden"
# 关键：给 Ctrl+T 触发的 fzf 窗口也绑定 Tab 补全
export FZF_CTRL_T_OPTS="--bind 'tab:accept,enter:accept' $FZF_CTRL_T_OPTS"
# 大小写不敏感匹配
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# 移除补全前缀限制，补全更顺滑
zstyle ':fzf-tab:*' prefix ''

# Vi风格按键绑定
zinit light jeffreytse/zsh-vi-mode
function zvm_after_init() {
    # fzf-history-widget
    bindkey -M emacs "^R" fzf-history-widget
    bindkey -M vicmd "^R" fzf-history-widget
    bindkey -M viins "^R" fzf-history-widget
    # fzf-file-widget
    bindkey -M emacs "^T" fzf-file-widget
    bindkey -M vicmd "^T" fzf-file-widget
    bindkey -M viins "^T" fzf-file-widget
    # 禁用fzf-cd-widget
    bindkey -M emacs -r "^[c"
    bindkey -M vicmd -r "^[c"
    bindkey -M viins -r "^[c"
    # 禁用fzf-tab-debug
    bindkey -M emacs -r "^X."
    bindkey -M vicmd -r "^X."
    bindkey -M viins -r "^X."
}

######################
# 选项
######################
setopt autocd       # 输入目录名自动跳转
setopt promptsubst  # 在提示符中启用命令替换
setopt ignore_eof   # 禁用EOF行为

######################
# 环境变量
######################
export LOCAL_PATH="$HOME/.local/bin"
if [[ -d "$LOCAL_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$LOCAL_PATH":* ]] && export PATH="${PATH:+${PATH}:}$LOCAL_PATH"
fi

export HOME_APP="$HOME/app"
export NVIM_PATH="$HOME_APP/nvim-linux-x86_64/bin"
if [[ -d "$NVIM_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$NVIM_PATH":* ]] && export PATH="${PATH:+${PATH}:}$NVIM_PATH"
fi
export TEX_PATH="$HOME_APP/texlive/2025/bin/x86_64-linux"
export TEX_MAN_PATH="$HOME_APP/texlive/2025/texmf-dist/doc/man"
export TEX_INFO_PATH="$HOME_APP/texlive/2025/texmf-dist/doc/info"
if [[ -d "$TEX_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$TEX_PATH":* ]] && export PATH="${PATH:+${PATH}:}$TEX_PATH"
    [[ ! ":$MANPATH:" == *:"$TEX_MAN_PATH":* ]] && export MANPATH="${MANPATH:+${MANPATH}:}$TEX_MAN_PATH"
    [[ ! ":$INFOPATH:" == *:"$TEX_INFO_PATH":* ]] && export INFOPATH="${INFOPATH:+${INFOPATH}:}$TEX_INFO_PATH"
fi

######################
# 别名
######################
alias nv="$HOME_APP/nvim-linux-x86_64/bin/nvim"
alias ya="yazi"
alias py="python3"    
# windows的cmd
alias cmd="/mnt/c/Windows/System32/cmd.exe /c"  

######################
# 网络通信
######################
export http_proxy=http://172.21.160.1:7890
export https_proxy=http://172.21.160.1:7890

###########################
# 清除痕迹
###########################
clean-tracks() {
    rm -rf /mnt/c/Users/sunny/AppData/Roaming/Microsoft/Windows/Recent/*
    rm -rf /mnt/c/Users/sunny/AppData/Roaming/Microsoft/Office/Recent/*
    rm -rf /mnt/c/Users/sunny/AppData/Roaming/kingsoft/office6/backup/*
    rm -rf /mnt/c/Users/sunny/AppData/Roaming/Adobe/Common/"Media Cache"/*
    rm -rf /mnt/c/Users/sunny/AppData/Roaming/Adobe/Common/"Media Cache Files"/*
    rm -rf /mnt/c/Users/sunny/AppData/Roaming/Adobe/Common/"Peak Files"/*
    rm -rf /mnt/c/Users/sunny/AppData/Local/gif123/*.gif
    rm -rf /mnt/c/Users/sunny/Documents/"Tencent Files"/3648579049
    rm -rf /mnt/c/Users/sunny/Documents/"WeChat Files"/wxid_fp83u8nabg7i22/FileStorage/*
    rm -rf /mnt/c/Users/sunny/Pictures/QQplayerPic/*
}

###########################
# 软件配置
###########################
# rust
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# deno
[[ -s "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

# bun
export BUN_PATH="$HOME/.bun"
if [[ -d "$BUN_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$BUN_PATH":* ]] && export PATH="${PATH:+${PATH}:}${BUN_PATH}/bin"
    # bun completions
    [[ -s "$BUN_PATH/_bun" ]] && source "$BUN_PATH/_bun"
fi

# fnm
export FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]]; then
    [[ ! ":$PATH:" == *:"$FNM_PATH":* ]] && export PATH="${PATH:+${PATH}:}$FNM_PATH"
    source <(fnm env)
fi
