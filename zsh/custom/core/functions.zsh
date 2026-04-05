# ls优化
alias l="command ls --color=tty -lh"
alias ll="command ls --color=tty -lha"
alias ls="command ls --color=tty"

# 常用程序
alias nv=nvim

# explorer配置
function e() {
	explorer.exe .
	return 0
}

# yazi配置
function ya() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# 使用opencode
function code() {
	"${BASH_CONFIG_PATH}/ai/opencode-run.bash" "$@"
}
# 使用claude
function claude() {
	"${BASH_CONFIG_PATH}/ai/claude-run.bash"
}
# 使用goose
function goose() {
	"${BASH_CONFIG_PATH}/ai/goose-run.bash"
}
# 使用zeroclaw
function claw(){
	${BASH_CONFIG_PATH}/ai/zeroclaw-run.bash "$@"
}
function claw-chat() {
	local name="${1:-default}"
	shift || true
	podman exec -it "zeroclaw-${name}" zeroclaw agent "$@"
}

# powershell调用
function pwsh() {
  powershell.exe -Command "Start-Process powershell.exe -Verb RunAs -ArgumentList '-Command', '$1' -WindowStyle Hidden"
}

# 痕迹清理
function clean-tracks() {
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
