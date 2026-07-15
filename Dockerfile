# --- Stage 1: Build & Dependency Isolation ---
FROM node:18-alpine AS builder
WORKDIR /usr/src/app

# Copy dependency manifests
COPY package*.json ./

# Install ONLY production dependencies (ignores devDependencies)
RUN npm ci --only=production

# --- Stage 2: Hardened Secure Runtime ---
FROM gcr.io/distroless/nodejs18-debian12
WORKDIR /usr/src/app

# Copy production artifacts from build stage
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY app.js ./

# Expose port and run as non-root (handled natively by distroless)
EXPOSE 3000
CMD ["app.js"]
