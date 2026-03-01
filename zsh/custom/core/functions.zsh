# 使用codex
function code() {
	${SH_CONFIG}/codex/run-codex-container.sh "$@"
}

# yazi配置
function ya() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# powershell调用
function pwsh() {
  powershell.exe -Command "Start-Process powershell.exe -Verb RunAs -ArgumentList '-Command', '$1' -WindowStyle Hidden"
}

# 垃圾清理
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
