# Dockerfile (for React MFE)
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

EXPOSE 3004
# 3004 is the port for the about micro frontend
CMD ["npx", "serve", "dist", "-l", "3004"]