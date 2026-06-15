#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_PI_AGENT_CONFIG_DIR="${PROJECT_DIR}/home/.pi/agent"
IMAGE="${IMAGE:-pi:latest}"

if [[ ! -e "${LOCAL_PI_AGENT_CONFIG_DIR}" ]]; then
	mkdir -p "${LOCAL_PI_AGENT_CONFIG_DIR}"
	cp -a "${HOME}/.pi/agent/." "${LOCAL_PI_AGENT_CONFIG_DIR}/"
	cp "${HOME}/.pi/github_token.txt" "${LOCAL_PI_AGENT_CONFIG_DIR}/.."
fi

exec podman run --rm -it \
	--userns=keep-id \
	--cap-drop=all \
	--cap-add=SYS_ADMIN \
	--cap-add=SYS_CHROOT \
	--security-opt=no-new-privileges \
	-v "${PROJECT_DIR}:/workspace:rw" \
	-e HOME=/workspace/home \
	-e COLORTERM=truecolor \
	"${IMAGE}" \
	pi
