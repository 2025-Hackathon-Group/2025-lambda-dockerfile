# Simple dockerfile that builds the frontend and serves with Caddy
FROM node:18-alpine AS frontend-builder

WORKDIR /app

# Copy frontend package files
COPY 2025-lambda-pdf-translator-frontend/package.json ./
COPY 2025-lambda-pdf-translator-frontend/package-lock.json* ./

# Install dependencies
RUN npm ci

# Copy frontend source and build
COPY 2025-lambda-pdf-translator-frontend/ ./
RUN npm run build

# Serve with Caddy
FROM caddy:alpine
COPY --from=frontend-builder /app/dist /usr/share/caddy
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 80