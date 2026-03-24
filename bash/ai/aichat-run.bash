#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
PROJECT_KEY="$(printf '%s' "${PROJECT_DIR}" | sha256sum | cut -c1-12)"
CONTAINER="aichat-${PROJECT_KEY}"
IMAGE="${IMAGE:-aichat:latest}"

LOCAL_AICHAT_DIR="${PROJECT_DIR}/home/.config/aichat"
mkdir -p "${LOCAL_AICHAT_DIR}"

if [[ -d "${HOME}/.config/aichat" && -z "$(ls -A "$LOCAL_AICHAT_DIR")" ]]; then
  echo "Migrating existing ~/.config/aichat -> ${LOCAL_AICHAT_DIR} ..."
  cp -a "${HOME}/.config/aichat/." "${LOCAL_AICHAT_DIR}/"
fi

if ! podman container exists "${CONTAINER}"; then
	podman run -d \
		--name "${CONTAINER}" \
		--userns=keep-id \
		--cap-drop=all \
		--cap-add=SYS_ADMIN \
		--cap-add=SYS_CHROOT \
		--security-opt=no-new-privileges \
		-v "${PROJECT_DIR}:/workspace:rw" \
		-e HOME="/workspace/home" \
		"${IMAGE}" \
		sleep infinity >/dev/null	
elif [[ "$(podman inspect -f '{{.State.Running}}' "${CONTAINER}")"  != "true" ]]; then
	podman start "$CONTAINER" >/dev/null
fi

if [[ -t 0 && -t 1 ]]; then
	exec podman exec -it "${CONTAINER}" aichat "$@"
else
	exec podman exec -i "${CONTAINER}" aichat "$@"
fi
