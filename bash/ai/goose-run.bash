#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_GOOSE_CONFIG_DIR="${PROJECT_DIR}/home/.config/goose"
IMAGE="${IMAGE:-goose:latest}"

mkdir -p "${LOCAL_GOOSE_CONFIG_DIR}"
if [[ -d "${HOME}/.config/goose" && ! -e "${LOCAL_GOOSE_CONFIG_DIR}/config.yaml" ]]; then
	echo "Migrating existing ~/.config/goose into ${LOCAL_GOOSE_CONFIG_DIR} ..."
	cp -a "${HOME}/.config/goose/." "${LOCAL_GOOSE_CONFIG_DIR}/"
fi

exec podman run --rm -it \
	--userns=keep-id \
	--cap-drop=all \
	--cap-add=SYS_ADMIN \
	--cap-add=SYS_CHROOT \
	--security-opt=no-new-privileges \
	-v "${PROJECT_DIR}:/workspace:rw" \
	-e HOME=/workspace/home \
	-e GOOSE_DISABLE_KEYRING=1 \
	-e GOOSE_CONTEXT_LIMIT=262144 \
	-e GOOSE_MAX_TOKENS=128000 \
	"${IMAGE}" \
	goose session
