#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
LOCAL_CODEX_DIR="${PROJECT_DIR}/home/.codex"
IMAGE="${IMAGE:-codex:latest}"

if [[ ! -e "{LOCAL_CODEX_DIR}" ]]; then
	mkdir -p "${LOCAL_CODEX_DIR}"
	cp "${HOME}/.codex/config.toml" "${LOCAL_CODEX_DIR}/"
	cp "${HOME}/.codex/github_token.txt" "${LOCAL_CODEX_DIR}/"
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
