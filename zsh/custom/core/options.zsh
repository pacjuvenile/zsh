# 主机名
HOST=nixos

# 默认编辑器
export EDITOR=nvim

# 网络代理
export http_proxy=http://172.21.160.1:27890
export HTTP_PROXY=http://172.21.160.1:27890
export https_proxy=http://172.21.160.1:27890
export HTTPS_PROXY=http://172.21.160.1:27890

# cd优化
setopt autocd

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
