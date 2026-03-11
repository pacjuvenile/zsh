# 主机名
HOST=nixos

# 默认编辑器
export EDITOR=nvim

# 网络协议
export http_proxy=http://172.21.160.1:7890
export https_proxy=http://172.21.160.1:7890

# cd优化
setopt autocd

# ls优化
alias l="command ls --color=tty -lh"
alias ll="command ls --color=tty -lha"
alias ls="command ls --color=tty"

# 常用程序
alias nv=nvim
alias zj=zellij

# 历史命令
HISTSIZE=5000
HISTFILE="${HOME}/.zsh_history"
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_space
