############################
# Stage 1 – deps (install) #
############################
FROM node:18-alpine AS deps
WORKDIR /app
ENV NPM_CONFIG_LOGLEVEL=warn

# Copy lock files first for better layer‑caching
COPY package.json package-lock.json ./
RUN npm ci


####################################
# Stage 2 – dev  (hot‑reload)      #
#  • live Vite server on :5173     #
####################################
FROM node:18-alpine AS dev
WORKDIR /app
ENV NODE_ENV=development

# Re‑use node_modules from deps stage
COPY --from=deps /app/node_modules ./node_modules
# Bring in the rest of the source for live coding
COPY . .

EXPOSE 5173
# Use exec form of CMD for better compatibility
CMD ["npm", "run", "dev", "--", "--host"]


########################################
# Stage 3 – builder  (compile assets)  #
########################################
FROM node:18-alpine AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build assets
RUN npm run build


########################################
# Stage 4 – prod  (lean runtime)       #
########################################
FROM node:18-alpine AS prod
WORKDIR /app
ENV NODE_ENV=production

# Copy compiled output only
COPY --from=builder /app/.output ./.output
# If you keep non‑generated static assets, copy them as well:
COPY --from=builder /app/static ./static

RUN adduser -D app && chown -R app /app
USER app

EXPOSE 3000   # adapter‑node defaults to 3000
CMD ["node", ".output/server/index.js"]