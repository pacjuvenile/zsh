#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_CLAUDE_CONFIG_DIR="${PROJECT_DIR}/home/.claude"
IMAGE="${IMAGE:-claude:latest}"

mkdir -p "${LOCAL_CLAUDE_CONFIG_DIR}"
if [[ ! -e "${LOCAL_CLAUDE_CONFIG_DIR}/settings.json" ]]; then
	echo "Migrating existing ~/.claude into ${LOCAL_CLAUDE_CONFIG_DIR} ..."
	cp -a "${HOME}/.claude/." "${LOCAL_CLAUDE_CONFIG_DIR}/"
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
	claude --dangerously-skip-permissions
