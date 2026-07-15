# ==========================================
# STAGE 1: Build & Dependency Installation
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Copy dependency manifests first to leverage Docker caching layers
COPY package*.json ./

# Install production dependencies only (ignores devDependencies)
RUN npm ci --only=production

# ==========================================
# STAGE 2: Secure Production Runtime
# ==========================================
FROM node:20-alpine

WORKDIR /usr/src/app

# 1. Create a non-privileged system group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# 2. Copy production dependencies from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

# 3. Copy application source code with secure ownership
COPY --chown=appuser:appgroup . .

# 4. Switch from root to the secure system user
USER appuser

# 5. Expose application port (documentative only)
EXPOSE 3000

# 6. Execute the application securely
CMD ["node", "app.js"]
