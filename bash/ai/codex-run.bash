#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
LOCAL_CODEX_DIR="${PROJECT_DIR}/home/.codex"
IMAGE="${IMAGE:-codex:latest}"

mkdir -p "${LOCAL_CODEX_DIR}"
if [[ -d "${HOME}/.codex" && ! -e "${LOCAL_CODEX_DIR}/config.toml" ]]; then
	echo "Migrating existing ~/.codex into ${LOCAL_CODEX_DIR} ..."
	cp -a "${HOME}/.codex/." "${LOCAL_CODEX_DIR}/"
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
