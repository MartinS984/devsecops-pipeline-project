# ==========================================
# STAGE 1: Build & Dependency Installation
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Copy dependency manifests first (including the lockfile!)
COPY package.json package-lock.json* ./

# Install production dependencies only (using modern omit flag)
RUN npm ci --omit=dev

# ==========================================
# STAGE 2: Secure Production Runtime
# ==========================================
FROM node:20-alpine

WORKDIR /usr/src/app

# Create a non-privileged system group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy production dependencies from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Copy application source code with secure ownership
COPY --chown=appuser:appgroup . .

# Switch away from root to the secure system user
USER appuser

EXPOSE 3000

CMD ["node", "app.js"]
