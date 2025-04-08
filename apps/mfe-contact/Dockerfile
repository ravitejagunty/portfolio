# Reusable Multi-Stage Dockerfile Template for React MFEs with NGINX on Different Ports
# Replace <PORT> with the actual port for each MFE when using it

# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Stage 2: Serve
FROM nginx:1.24-alpine

# Copy built files to nginx html dir
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy NGINX config with custom port (replace <PORT>)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3005
CMD ["nginx", "-g", "daemon off;"]
