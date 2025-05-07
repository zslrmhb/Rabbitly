# AI Service

## 🐳 Local Development Helper

The `ai-service/run.sh` script lets you build, run, and manage the
ai-service container without remembering long Docker commands.

```bash
# Build image only
./ai-service/run.sh build

# First‑time run (creates the container)
./ai-service/run.sh run

# Stop / start the same container
./ai-service/run.sh stop
./ai-service/run.sh start

# Rebuild & recreate (handy after changing dependencies)
./ai-service/run.sh rebuild

# Remove the container entirely
./ai-service/run.sh rm