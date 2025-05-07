#!/usr/bin/env bash
# Unified helper for Rabbitly micro‑services using Docker Compose.
# Usage:
#   ./scripts/run.sh dev build            # build all dev images
#   ./scripts/run.sh dev up               # build if needed & start full dev stack
#   ./scripts/run.sh dev up frontend      # start only frontend
#   ./scripts/run.sh dev logs backend-api # tail logs
#   ./scripts/run.sh dev down             # stop & remove dev containers
#
#   ./scripts/run.sh prod build
#   ./scripts/run.sh prod up
#   ./scripts/run.sh prod down


set -euo pipefail


ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_DEV="-f ${ROOT_DIR}/docker-compose.dev.yml"
COMPOSE_PROD="-f ${ROOT_DIR}/docker-compose.prod.yml"

ENV=${1:-dev}          # dev | prod
CMD=${2:-help}         # build | up | down | start | stop | rm | logs
SERVICE=${3:-}         # optional service name

case "$ENV" in
  dev)  COMPOSE_CMD="docker compose $COMPOSE_DEV" ;;
  prod) COMPOSE_CMD="docker compose $COMPOSE_PROD" ;;
  *)    echo "First arg must be 'dev' or 'prod'"; exit 1 ;;
esac

build() {  $COMPOSE_CMD build ${SERVICE:+$SERVICE}; }
up()    {  $COMPOSE_CMD up -d --build ${SERVICE:+$SERVICE}; }
down()  {  $COMPOSE_CMD down --remove-orphans -v; }
start() {  $COMPOSE_CMD start ${SERVICE:+$SERVICE}; }
stop()  {  $COMPOSE_CMD stop  ${SERVICE:+$SERVICE}; }
rmc()   {  $COMPOSE_CMD rm -f ${SERVICE:+$SERVICE}; }
logs()  {  $COMPOSE_CMD logs -f ${SERVICE:+$SERVICE}; }

case "$CMD" in
  build)  build ;;
  up)     up ;;
  down)   down ;;
  start)  start ;;
  stop)   stop ;;
  rm)     rmc ;;
  logs)   logs ;;
  help|*) cat <<EOF
Usage: $0 <dev|prod> <command> [service]

Commands:
  build   Build images (all or specified service)
  up      Build (if needed) & start containers
  down    Stop & remove containers + orphans + volumes
  start   Start existing stopped containers
  stop    Stop running containers
  rm      Remove containers without networks/volumes
  logs    Tail logs (optionally a specific service)

Examples:
  $0 dev up                 # full dev stack
  $0 dev up frontend        # just frontend
  $0 dev logs backend-api   # stream logs
  $0 prod build             # build production images
EOF
  ;;
esac