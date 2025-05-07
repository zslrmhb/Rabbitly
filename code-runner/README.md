# Code Runner

## 🐳 Local Development Helper

The `code-runner/run.sh` script lets you build, run, and manage the
code‑runner container without remembering long Docker commands.

```bash
# Build image only
./code-runner/run.sh build

# First‑time run (creates the container)
./code-runner/run.sh run

# Stop / start the same container
./code-runner/run.sh stop
./code-runner/run.sh start

# Rebuild & recreate (handy after changing dependencies)
./code-runner/run.sh rebuild

# Remove the container entirely
./code-runner/run.sh rm