#!/usr/bin/env bash
# build | run | start | stop | rm | rebuild
# A one‑stop helper for the backend‑api service.

set -euo pipefail

NAME="backend-api-dev"
IMAGE="rabbitly-backend:dev"
PORT="8000"
# DOCKERFILE_DIR="$(dirname "$0")"
DOCKERFILE_DIR="$(cd "$(dirname "$0")"; pwd -W)" # for windows


build () {
  echo "🔨  Building $IMAGE (dev target)…"
  # Use empty Docker config to avoid missing credential helper errors.
  DOCKER_CONFIG=/tmp/empty-config docker build --target dev -t "$IMAGE" "$DOCKERFILE_DIR"
}

run_container () {
  docker run -d \
    -p "${PORT}:${PORT}" \
    -v "${DOCKERFILE_DIR}":/app \
    --env-file "${DOCKERFILE_DIR}/../.env.example" \
    --name "${NAME}" \
    "$IMAGE"
  echo "🚀  Container ${NAME} started → http://localhost:${PORT}"
}

case "${1:-}" in
  build)
    build
    ;;
  rebuild)
    docker rm -f "$NAME" 2>/dev/null || true
    build
    run_container
    ;;
  run)
    # Build image if it doesn’t exist
    if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
      build
    fi
    # Run only if container name isn’t already taken
    if docker ps -a --format '{{.Names}}' | grep -q "^${NAME}\$"; then
      echo "⚠️  Container ${NAME} already exists. Use start/stop/rm."
      exit 1
    fi
    run_container
    ;;
  start)
    docker start -a "$NAME"
    ;;
  stop)
    docker stop "$NAME"
    ;;
  rm)
    docker rm -f "$NAME"
    ;;
  *)
    echo "Usage: $0 {build|run|start|stop|rm|rebuild}"
    exit 1
    ;;
esac