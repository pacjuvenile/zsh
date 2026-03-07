#!/usr/bin/env bash
# Start Codex in a rootless Podman container with only the current directory mounted.
# Persistent Codex config is stored under ./.codex-home/.codex by default.

if ! command -v podman >/dev/null 2>&1; then
  echo "Error: podman is not installed or not in PATH." >&2
  exit 1
fi

PROJECT_DIR="$(pwd)"
LOCAL_HOME_DIR="${PROJECT_DIR}/home"
LOCAL_CODEX_DIR="${LOCAL_HOME_DIR}/.codex"
IMAGE="${IMAGE:-codex:latest}"

mkdir -p "${LOCAL_CODEX_DIR}"

if [[ -d "${HOME}/.codex" && ! -e "${LOCAL_CODEX_DIR}/config.toml" ]]; then
  echo "Migrating existing ~/.codex into ${LOCAL_CODEX_DIR} ..."
  cp -a "${HOME}/.codex/." "${LOCAL_CODEX_DIR}/"
fi

if ! podman image exists "${IMAGE}"; then
  echo "Error: image '${IMAGE}' not found." >&2
  echo "Build it first with: podman build -t ${IMAGE} -f Containerfile ." >&2
  exit 1
fi

exec podman run --rm -it \
  --userns=keep-id \
  --cap-drop=all \
  --security-opt=no-new-privileges \
  -v "${PROJECT_DIR}:/workspace:rw" \
  -e HOME=/workspace/home \
	-e NIX_REMOTE=local \
  "${IMAGE}"
