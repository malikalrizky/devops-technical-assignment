FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Run tests and build
RUN npm run test && npm run build

# Production image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy built assets from builder
COPY --from=builder /app/dist ./dist
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production && \
    # Add non-root user
    adduser -D nodeuser && \
    # Set correct permissions
    chown -R nodeuser:nodeuser /app

# Switch to non-root user
USER nodeuser

# Expose application port
EXPOSE 3000

# Start application
CMD ["npm", "start"]