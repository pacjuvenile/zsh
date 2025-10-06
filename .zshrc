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

# Vi风格按键绑定
zinit light jeffreytse/zsh-vi-mode
function zvm_after_init() {
    bindkey -r "^B"
    # 保持^C终止进程的功能
    bindkey -r "^C"
    # 解绑^B backward-char
    bindkey -r "^B"
    # 解绑^T forward-char
    bindkey -r "^T"
    # fzf-file-widget
    bindkey "^F" fzf-file-widget
    # 更改fzf-cd-widget
    bindkey -r "^[c"
    bindkey "^D" fzf-cd-widget
    # fzf-history-widget
    bindkey "^R" fzf-history-widget
    # 禁用fzf-tab-debug
    bindkey -r "^X."
}

######################
# fzf配置
######################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
export EDITOR=nvim
# export TERMINAL=alacritty   # 设置默认的终端模拟器
# export BROWSER=com.brave.Browser # 设置默认的浏览器

######################
# 别名
######################
alias nv=nvim
alias ya="yazi"
alias py="python3"    # python3
alias cmd="/mnt/c/Windows/System32/cmd.exe /c"  # windows的cmd
alias of7="source ~/OpenFOAM/OpenFOAM7/OpenFOAM-7/etc/bashrc"
alias of8="source ~/OpenFOAM/OpenFOAM8/OpenFOAM-8/etc/bashrc"
alias of9="source ~/OpenFOAM/OpenFOAM9/OpenFOAM-9/etc/bashrc"
alias of10="source ~/OpenFOAM/OpenFOAM10/OpenFOAM-10/etc/bashrc"
alias of11="source ~/OpenFOAM/OpenFOAM11/OpenFOAM-11/etc/bashrc"
alias of12="source ~/OpenFOAM/OpenFOAM12/OpenFOAM-12/etc/bashrc"

######################
# 网络通信
######################
export http_proxy=http://172.21.160.1:7890
export https_proxy=http://172.21.160.1:7890

######################
# 应用配置
######################
source ~/.cargo/env # cargo配置
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
() {
    emulate -L zsh
    bindkey -r "^B"
}

# deno配置
. "/home/sunny/.deno/env"
