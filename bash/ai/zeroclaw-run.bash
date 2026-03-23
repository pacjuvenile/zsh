#!/usr/bin/env bash
PROJECT_DIR="$(pwd)"
IMAGE="${IMAGE:-zeroclaw:latest}"

NAME="default"
if [[ $# -gt 0 && "$1" != -* ]]; then
	NAME="$1"
	shift
fi

if ! [[ "$NAME" =~ ^[A-Za-z0-9._-]+$ ]]; then
	echo "invalid name: $NAME" >&2
	exit 2;
fi

LOCAL_HOME_DIR="${PROJECT_DIR}/home/${NAME}"
LOCAL_ZEROCLAW_DIR="${LOCAL_HOME_DIR}/.zeroclaw"
mkdir -p "${LOCAL_ZEROCLAW_DIR}"

if [[ -d "${HOME}/.zeroclaw" && -z "$(ls -A "$LOCAL_ZEROCLAW_DIR")" ]]; then
  echo "Migrating existing ~/.zeroclaw into ${LOCAL_ZEROCLAW_DIR} ..."
  cp -a "${HOME}/.zeroclaw/." "${LOCAL_ZEROCLAW_DIR}/"
fi

exec podman run -d \
	--name "zeroclaw-${NAME}" \
  --userns=keep-id \
  --cap-drop=all \
	--cap-add=SYS_ADMIN \
	--cap-add=SYS_CHROOT \
  --security-opt=no-new-privileges \
  -v "${PROJECT_DIR}:/workspace:rw" \
  -e HOME="/workspace/home/${NAME}" \
  "${IMAGE}" zeroclaw daemon "$@"
