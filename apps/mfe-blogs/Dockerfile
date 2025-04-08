# Stage 1: Build the Angular app
FROM node:18-alpine as builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy build output to nginx html directory
COPY --from=builder /app/dist/mfe-blogs /usr/share/nginx/html

# Custom nginx config (will set port to 3003)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose 3003 instead of default 80
EXPOSE 3003

CMD ["nginx", "-g", "daemon off;"]