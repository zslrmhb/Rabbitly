#!/usr/bin/env bash
# Remove orphan containers, dangling images and unused volumes.

set -eu

echo "🔎  Stopping & removing services (dev stack)…"
docker compose -f ../docker-compose.dev.yml down --remove-orphans -v

echo "🧹  Pruning dangling images & build cache…"
docker image prune -f
docker builder prune -f

# echo "🗑️   Removing stopped containers without names (if any)…"
# docker container prune -f

echo "✅  Docker workspace is tidy."