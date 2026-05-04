#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_CLAUDE_CONFIG_DIR="${PROJECT_DIR}/home/.claude"
	IMAGE="${IMAGE:-claude:2.1.87}"

mkdir -p "${LOCAL_CLAUDE_CONFIG_DIR}"
if [[ ! -e "${LOCAL_CLAUDE_CONFIG_DIR}/settings.json" ]]; then
	cp "${HOME}/.claude/settings.json" "${LOCAL_CLAUDE_CONFIG_DIR}/"
	cp "${HOME}/.claude/.claude.json" "${PROJECT_DIR}/home/.claude.json"
	cp "${HOME}/.claude/CLAUDE.md" "${LOCAL_CLAUDE_CONFIG_DIR}/CLAUDE.md"
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
