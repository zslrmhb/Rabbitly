#!/usr/bin/env bash
# build | run | start | stop | rm | rebuild
# A one‑stop helper for the backend‑api service.

set -euo pipefail

NAME="backend-api-dev"
IMAGE="rabbitly-backend:dev"
PORT="8000"
# DOCKERFILE_DIR="$(dirname "$0")"
DOCKERFILE_DIR="$(cd "$(dirname "$0")"; pwd -W)" # for windows

MYSQL_CONTAINER="rabbitly-mysql"
COMPOSE_FILE="$DOCKERFILE_DIR/../docker-compose.dev.yml"

build () {
  echo "🔨  Building $IMAGE (dev target)…"
  # Use empty Docker config to avoid missing credential helper errors.
  DOCKER_CONFIG=/tmp/empty-config docker build --target dev -t "$IMAGE" "$DOCKERFILE_DIR"
}

ensure_db_running () {
  if ! docker ps --format '{{.Names}}' | grep -q "^${MYSQL_CONTAINER}$"; then
    echo " MySQL container not running. Starting it now..."
    docker-compose -f "$COMPOSE_FILE" up -d db
  else
    echo " MySQL container $MYSQL_CONTAINER is already running."
  fi
}

run_container () {
  ensure_db_running
  docker run -d \
    --network rabbitly_default \
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
    ensure_db_running
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