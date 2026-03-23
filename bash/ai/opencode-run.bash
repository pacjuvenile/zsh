#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
LOCAL_HOME_DIR="${PROJECT_DIR}/home"
LOCAL_OPENCODE_DIR="${LOCAL_HOME_DIR}/.config/opencode"
IMAGE="${IMAGE:-opencode:latest}"

mkdir -p "${LOCAL_OPENCODE_DIR}"

if [[ -d "${HOME}/.config/opencode" && ! -e "${LOCAL_OPENCODE_DIR}/opencode.jsonc" ]]; then
  echo "Migrating existing ~/.config/opencode into ${LOCAL_OPENCODE_DIR} ..."
  cp -a "${HOME}/.config/opencode/." "${LOCAL_OPENCODE_DIR}/"
fi

exec podman run --rm -it \
  --userns=keep-id \
  --cap-drop=all \
	--cap-add=SYS_ADMIN \
	--cap-add=SYS_CHROOT \
  --security-opt=no-new-privileges \
  -v "${PROJECT_DIR}:/workspace:rw" \
  -e HOME=/workspace/home \
	-e OPENCODE_EXPERIMENTAL_OUTPUT_TOKEN_MAX=128000 \
  "${IMAGE}" opencode
