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
source "${ZINIT_HOME}/zinit.zsh"
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_COMMAND="fdfind \"\" /home/sunny/  /mnt/c/Users/sunny/Desktop/ /mnt/c/Users/sunny/AppData/Roaming/ /mnt/c/Users/sunny/.config/ -i -t f -t d -t l --hidden --follow"

# Vi风格按键绑定
zinit light jeffreytse/zsh-vi-mode
function zvm_after_init() {
    # fzf-history-widget
    bindkey -M emacs "^R" fzf-history-widget
    bindkey -M vicmd "^R" fzf-history-widget
    bindkey -M viins "^R" fzf-history-widget
    # 更改fzf-file-widget
    bindkey -M emacs -r "^T"
    bindkey -M vicmd -r "^T"
    bindkey -M viins -r "^T"
    bindkey -M emacs "^F" fzf-file-widget
    bindkey -M vicmd "^F" fzf-file-widget
    bindkey -M viins "^F" fzf-file-widget
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
# zsh选项
######################
setopt autocd       # 输入目录名自动跳转
setopt promptsubst  # 在提示符中启用命令替换
setopt ignore_eof   # 禁用EOF行为

######################
# 设置环境变量
######################
export PATH="$HOME/nvim-linux-x86_64/bin:$PATH"

######################
# 别名
######################
alias nv="$HOME/nvim-linux-x86_64/bin/nvim"
alias ya="yazi"
alias py="python3"    
# windows的cmd
alias cmd="/mnt/c/Windows/System32/cmd.exe /c"  
# OpenFOAM多版本
# alias of7="source ~/OpenFOAM/OpenFOAM7/OpenFOAM-7/etc/bashrc"
# alias of8="source ~/OpenFOAM/OpenFOAM8/OpenFOAM-8/etc/bashrc"
# alias of9="source ~/OpenFOAM/OpenFOAM9/OpenFOAM-9/etc/bashrc"
# alias of10="source ~/OpenFOAM/OpenFOAM10/OpenFOAM-10/etc/bashrc"
# alias of11="source ~/OpenFOAM/OpenFOAM11/OpenFOAM-11/etc/bashrc"
# alias of12="source ~/OpenFOAM/OpenFOAM12/OpenFOAM-12/etc/bashrc"

######################
# 网络通信
######################
export http_proxy=http://172.21.160.1:7890
export https_proxy=http://172.21.160.1:7890

######################
# 应用配置
######################
source ~/opt/gradle/bashrc.sh # gradle配置
source ~/opt/comsol/bashrc.sh # comsol配置
source ~/opt/verilog/bashrc.sh  # verilog配置
source ~/opt/python/bashrc.sh    # python配置
word() {
    cmd  "WINWORD $(wslpath -w "$@")"   # word配置
}
excel() {
    cmd "EXCEL $(wslpath -w "$@")"  # excel配置
}
ppt() {
    cmd "POWERPNT $(wslpath -w "$@")"   # ppt配置
}
# parafoam配置
parafoam() {
    local foamfile="$(basename $(pwd)).foam"
    if [ ! -f "$foamfile" ];then
        touch "$foamfile"
    fi
    cmd /c "paraview $foamfile"
}
source ~/opt/clean/bashrc.sh    # 痕迹清理

# rust
source ~/.cargo/env

# deno
source "/home/sunny/.deno/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/home/sunny/.bun/_bun" ] && source "/home/sunny/.bun/_bun"

# fnm
FNM_PATH="/home/sunny/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
