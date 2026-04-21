#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_PI_CONFIG_DIR="${PROJECT_DIR}/home/.pi"
IMAGE="${IMAGE:-pi:latest}"

mkdir -p "${LOCAL_PI_CONFIG_DIR}"
if [[ ! -e "${LOCAL_PI_CONFIG_DIR}/agent/models.json" ]]; then
	echo "Migrating existing ~/.pi into ${LOCAL_PI_CONFIG_DIR} ..."
	cp -a "${HOME}/.pi/." "${LOCAL_PI_CONFIG_DIR}/"
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
	pi
