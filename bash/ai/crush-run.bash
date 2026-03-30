#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
LOCAL_CRUSH_DIR="${PROJECT_DIR}/home/.config/crush"
IMAGE="${IMAGE:-crush:latest}"

mkdir -p "${LOCAL_CRUSH_DIR}"
if [[ -d "${HOME}/.config/crush" && ! -e "${LOCAL_CRUSH_DIR}/crush.jsonc" ]]; then
	echo "Migrating existing ~/.config/crush into ${LOCAL_CRUSH_DIR} ..."
	cp -a "${HOME}/.config/crush/." "${LOCAL_CRUSH_DIR}/"
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
	crush
