# Backend API

## 🐳 Local Development Helper

The `backend-api/run.sh` script lets you build, run, and manage the
backend‑api container without remembering long Docker commands.

```bash
# Build image only
./backend-api/run.sh build

# First‑time run (creates the container)
./backend-api/run.sh run

# Stop / start the same container
./backend-api/run.sh stop
./backend-api/run.sh start

# Rebuild & recreate (handy after changing dependencies)
./backend-api/run.sh rebuild

# Remove the container entirely
./backend-api/run.sh rm