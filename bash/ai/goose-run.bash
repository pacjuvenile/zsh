#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_HOME_DIR="${PROJECT_DIR}/home"
LOCAL_GOOSE_CONFIG_DIR="${LOCAL_HOME_DIR}/.config/goose"
IMAGE="${IMAGE:-goose:latest}"

mkdir -p "${LOCAL_GOOSE_CONFIG_DIR}"

if [[ -d "${HOME}/.config/goose" && ! -e "${LOCAL_GOOSE_CONFIG_DIR}/config.yaml" ]]; then
  echo "Migrating existing ~/.config/goose into ${LOCAL_GOOSE_CONFIG_DIR} ..."
  cp -a "${HOME}/.config/goose/." "${LOCAL_GOOSE_CONFIG_DIR}/"
fi

if [[ $# -eq 0 ]]; then
  set -- session
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
  "${IMAGE}" goose "$@"
