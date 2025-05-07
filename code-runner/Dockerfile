# Stage 1: Base image with Python and Docker CLI
FROM python:3.12-slim AS base
ENV PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1
RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*
WORKDIR /app
ENV PYTHONPATH=/app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


# Stage 2: development image with reload
FROM base AS dev
COPY . .
EXPOSE 9100
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "9100", "--reload"]



# Stage 3: Production image
FROM base AS prod
COPY . .
EXPOSE 9100
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "9100"]
