#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_CLAW_CONFIG_DIR="${PROJECT_DIR}/home/.config/claw/settings.json"
IMAGE="${IMAGE:-claw:latest}"

mkdir -p "${LOCAL_CLAW_CONFIG_DIR}"
if [[ ! -e "${LOCAL_CLAW_CONFIG_DIR}/settings.json" ]]; then
	echo "Migrating existing ~/.config/claw into ${LOCAL_CLAW_CONFIG_DIR} ..."
	cp -a "${HOME}/.config/claw/." "${LOCAL_CLAW_CONFIG_DIR}/"
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
	claw

