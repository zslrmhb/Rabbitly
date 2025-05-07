# Stage 1: Base image with Python and Docker CLI
FROM python:3.12-slim AS base

# Avoid Python buffering and cache
ENV PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1

# Install Docker CLI (for running sandbox containers)
RUN apt-get update \
    && apt-get install -y docker.io \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Production image
FROM base AS prod

# Copy application code
COPY . .

# Expose the runner port
EXPOSE 9100

# Run the worker that listens for execution jobs
CMD ["python", "worker.py"]
