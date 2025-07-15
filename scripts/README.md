# Scripts

## run.sh

Unified helper around **Docker Compose**.

```bash
# Dev workflow
./scripts/run.sh dev build            # build all dev images
./scripts/run.sh dev up               # build if needed & start full dev stack
./scripts/run.sh dev up frontend      # build if needed, start only frontend
./scripts/run.sh dev start            # start containers
./scripts/run.sh dev stop             # stop containers
./scripts/run.sh dev down             # stop & remove dev containers

# Production
./scripts/run.sh prod build
./scripts/run.sh prod up
./scripts/run.sh prod down
```

Commands: `build | up | down | start | stop`.

## clean.sh

Tidies your local Docker workspace—removes orphans, dangling images and exited containers.

```bash
./scripts/clean.sh
```