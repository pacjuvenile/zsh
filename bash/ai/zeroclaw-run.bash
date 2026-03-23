#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
LOCAL_HOME_DIR="${PROJECT_DIR}/home"
LOCAL_ZEROCLAW_DIR="${LOCAL_HOME_DIR}/.zeroclaw"
IMAGE="${IMAGE:-zeroclaw:latest}"

mkdir -p "${LOCAL_ZEROCLAW_DIR}"

if [[ -d "${HOME}/.zeroclaw" && -z "$(ls -A "$LOCAL_ZEROCLAW_DIR")" ]]; then
  echo "Migrating existing ~/.zeroclaw into ${LOCAL_ZEROCLAW_DIR} ..."
  cp -a "${HOME}/.zeroclaw/." "${LOCAL_ZEROCLAW_DIR}/"
fi

exec podman run --rm -it \
  --userns=keep-id \
  --cap-drop=all \
	--cap-add=SYS_ADMIN \
	--cap-add=SYS_CHROOT \
  --security-opt=no-new-privileges \
  -v "${PROJECT_DIR}:/workspace:rw" \
  -e HOME=/workspace/home \
  "${IMAGE}"
