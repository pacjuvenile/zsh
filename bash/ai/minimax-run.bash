#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
LOCAL_CODEX_DIR="${PROJECT_DIR}/home/.codex"
IMAGE="${IMAGE:-codex:0.57.0}"

mkdir -p "${LOCAL_CODEX_DIR}"
if [[ -d "${HOME}/.codex" && ! -e "${LOCAL_CODEX_DIR}/config.toml" ]]; then
	echo "Migrating existing ~/.codex into ${LOCAL_CODEX_DIR} ..."
	cp "${HOME}/.codex/minimax.toml" "${LOCAL_CODEX_DIR}/config.toml"
fi

exec podman run --rm -it \
	--userns=keep-id \
	--cap-drop=all \
	--cap-add=SYS_ADMIN \
	--cap-add=SYS_CHROOT \
	--security-opt=no-new-privileges \
	-v "${PROJECT_DIR}:/workspace:rw" \
	-e HOME=/workspace/home \
	"${IMAGE}" \
	codex
