# Stage 1: install dependencies
FROM node:18-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# Stage 2: build the SvelteKit app
FROM node:18-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Stage 3: production image
FROM node:18-alpine AS prod
WORKDIR /app
ENV NODE_ENV=production
# Copy the built output
COPY --from=builder /app/.output ./.output
# If you have static assets not in .output, copy them:
COPY --from=builder /app/static ./static
# Expose the port (ensure it matches your SvelteKit adapter)
EXPOSE 3000
# Launch the Node.js server
CMD ["node", ".output/server/index.js"]
