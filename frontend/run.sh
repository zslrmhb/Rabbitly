#!/usr/bin/env bash
# build | run | start | stop | rm | rebuild
# Helper script for the Rabbitly FRONTEND (SvelteKit) service.

set -euo pipefail

NAME="frontend-dev"
IMAGE="rabbitly-frontend:dev"
PORT="5173"
DOCKERFILE_DIR="$(dirname "$0")"

# Detect platform and set appropriate Docker platform flag
HOST_PLATFORM=$(uname -m)
if [ "$HOST_PLATFORM" = "arm64" ] || [ "$HOST_PLATFORM" = "aarch64" ]; then
  PLATFORM_FLAG="--platform linux/arm64"
else
  PLATFORM_FLAG="--platform linux/amd64"
fi

build () {
  echo "🔨  Building $IMAGE (dev target) for platform: $(uname -m)…"
  DOCKER_CONFIG=/tmp/empty-config docker build $PLATFORM_FLAG --target dev -t "$IMAGE" "$DOCKERFILE_DIR"
}

run_container () {
  docker run -d \
    $PLATFORM_FLAG \
    -p "${PORT}:${PORT}" \
    -v "${DOCKERFILE_DIR}":/app \
    --env-file "${DOCKERFILE_DIR}/../.env.example" \
    --name "${NAME}" \
    "$IMAGE"
  echo "🚀  Container ${NAME} started → http://localhost:${PORT}"
  echo "📝  Following logs (Ctrl+C to detach)..."
  docker logs -f "${NAME}"
}

start_container() {
  echo "Starting container ${NAME}..."
  docker start "${NAME}"
  echo "📝  Following logs (Ctrl+C to detach)..."
  docker logs -f "${NAME}"
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
    # Build if missing
    if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
      build
    fi
    # Refuse if container already exists
    if docker ps -a --format '{{.Names}}' | grep -q "^${NAME}\$"; then
      echo "⚠️  Container ${NAME} already exists. Use start/stop/rm."
      exit 1
    fi
    run_container
    ;;
  start)
    start_container
    ;;
  stop)
    docker stop "$NAME"
    ;;
  rm)
    docker rm -f "$NAME"
    ;;
  debug)
    echo "Host platform: $(uname -m)"
    echo "Inspecting container configuration..."
    docker inspect "$NAME"
    echo "Container logs:"
    docker logs "$NAME"
    ;;
  clean)
    echo "Removing container and image..."
    docker rm -f "$NAME" 2>/dev/null || true
    docker rmi "$IMAGE" 2>/dev/null || true
    echo "Done cleaning up."
    ;;
  *)
    echo "Usage: $0 {build|run|start|stop|rm|rebuild|debug|clean}"
    exit 1
    ;;
esac