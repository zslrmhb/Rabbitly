#!/usr/bin/env bash
# build | run | start | stop | rm | rebuild
# Helper for the code‑runner service container.

set -euo pipefail

NAME="code-runner-dev"
IMAGE="rabbitly-runner:dev"
PORT="9100"
DOCKERFILE_DIR="$(dirname "$0")"

build () {
  echo "🔨  Building $IMAGE (dev target)…"
  DOCKER_CONFIG=/tmp/empty-config docker build --target dev -t "$IMAGE" "$DOCKERFILE_DIR"
}

run_container () {
  docker run -d \
    -p "${PORT}:${PORT}" \
    -v "${DOCKERFILE_DIR}":/app \
    --env-file "${DOCKERFILE_DIR}/../.env.example" \
    --name "${NAME}" \
    --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock \
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
    if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
      build
    fi
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