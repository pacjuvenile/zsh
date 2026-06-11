#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
LOCAL_CODEX_DIR="${PROJECT_DIR}/home/.codex"
IMAGE="${IMAGE:-codex:latest}"

mkdir -p "${LOCAL_CODEX_DIR}"
if [[ -d "${HOME}/.codex" && ! -e "${LOCAL_CODEX_DIR}/config.toml" ]]; then
	cp "${home}/.codex/config.toml" "${local_codex_dir}/"
	cp "${home}/.codex/github_token.txt" "${local_codex_dir}/"
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
