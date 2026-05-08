#!/usr/bin/env bash
PROJECT_DIR="$(pwd -P)"
LOCAL_CLAUDE_CONFIG_DIR="${PROJECT_DIR}/home/.claude"
IMAGE="${IMAGE:-claude:2.1.88}"

if [[ ! -e "${LOCAL_CLAUDE_CONFIG_DIR}" ]]; then
	mkdir -p "${LOCAL_CLAUDE_CONFIG_DIR}"
	cp "${HOME}/.claude/settings.json" "${LOCAL_CLAUDE_CONFIG_DIR}/"
	cp "${HOME}/.claude/.claude.json" "${PROJECT_DIR}/home/.claude.json"
	cp "${HOME}/.claude/CLAUDE.md" "${LOCAL_CLAUDE_CONFIG_DIR}/CLAUDE.md"
	cp "${HOME}/.claude/proxy.env" "${LOCAL_CLAUDE_CONFIG_DIR}/proxy.env"
fi

exec podman run --rm -it \
	--userns=keep-id \
	--cap-drop=all \
	--cap-add=SYS_ADMIN \
	--cap-add=SYS_CHROOT \
	--security-opt=no-new-privileges \
	-v "${PROJECT_DIR}:/workspace:rw" \
	-e HOME=/workspace/home \
	-e NO_PROXY=localhost,127.0.0.1,::1 \
	-e no_proxy=localhost,127.0.0.1,::1 \
	"${IMAGE}" \
	bash -lc '
		PROXY_CONFIG="/workspace/home/.claude/proxy.env"
		source "${PROXY_CONFIG}"
		clawgate --mode=api --apiKey="${OPENAI_COMPAT_API_KEY}" --baseUrl="${OPENAI_COMPAT_BASE_URL}" ${CLAWGATE_EXTRA_ARGS:-} &
		sleep 0.5
		claude --dangerously-skip-permissions
	'
