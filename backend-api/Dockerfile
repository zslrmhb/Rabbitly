# Stage 1: base image with dependencies
 FROM python:3.12-slim AS base
 WORKDIR /app
 ENV PYTHONUNBUFFERED=1
 COPY requirements.txt .
 RUN pip install --no-cache-dir -r requirements.txt

 # Stage 2: development image with reload
 FROM base AS dev
 COPY . .
 EXPOSE 8000
 CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

 # Stage 3: production image
 FROM base AS prod
 COPY . .
 EXPOSE 8000
 CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]