# Stage 1: Base image with dependencies
FROM python:3.12-slim AS base
WORKDIR /app
ENV PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1

# Install system dependencies (if any)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Development image with auto-reload
FROM base AS dev
COPY . .
EXPOSE 9000
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "9000", "--reload"]

# Stage 3: Production image
FROM base AS prod
COPY . .
EXPOSE 9000
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "9000"]