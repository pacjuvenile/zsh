#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_HERMES_CONFIG_DIR="${PROJECT_DIR}/home/.hermes"
IMAGE="${IMAGE:-hermes:latest}"

mkdir -p "${LOCAL_HERMES_CONFIG_DIR}"
if [[ ! -e "${LOCAL_HERMES_CONFIG_DIR}/config.yaml" ]]; then
	echo "Migrating existing ~/.hermes into ${LOCAL_HERMES_CONFIG_DIR} ..."
	cp -a "${HOME}/.hermes/." "${LOCAL_HERMES_CONFIG_DIR}/"
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
	hermes
